---
title: C语言内中文I/O及处理方法
date: 2020-06-07 20:43:47
tags:
  - 中文处理
  - 编码
categories:
  - Programming Languages
  - C
---

C语言内处理不同的字符编码一直是个重要问题，正好今天遇到了需要处理读取/输出中文的问题，把研究结果在这里记录一下。

<!--more-->

## `wchar_t` 类型

### 说明

定义于头文件 `wchar.h` 内，存储宽字符类型；`wchar_t` 类型的宽字符串可与使用 `char` 类型的多字节字符串互相转换。

宽字符串字面量在字面量前加 `L` 标记。*e.g.* `L"s-char-sequence"`

#### 相关类型

`wint_t` 类型是可保有任何合法宽字符，并至少多出一个值的整数类型 。

### I/O 函数

> 本节参考自中文 cppreference 的[文件输入/输出](https://zh.cppreference.com/w/c/io)一节。

#### 无格式 I/O

|      函数名      |                          函数原型                           |           说明            |
| :--------------: | :---------------------------------------------------------: | :-----------------------: |
| `fgetwc`/`getwc` |              `wint_t fgetwc( FILE *stream );`               |  从文件流获取一个宽字符   |
|     `fgetws`     | `wchar_t *fgetws( wchar_t *str, int count, FILE *stream );` | 从文件流获取一个宽字符串  |
|  `fputwc/putwc`  |        `wint_t fputwc( wchar_t ch, FILE *stream );`         |  将一个宽字符写入文件流   |
|     `fputws`     |      `int fputws( const wchar_t *str, FILE *stream );`      | 将一个宽字符串写入文件流  |
|    `getwchar`    |                  `wint_t getwchar(void);`                   | 从 `stdin` 读取一个宽字符 |
|    `putwchar`    |              `wint_t putwchar( wchar_t ch );`               | 将一个宽字符写入`stdout`  |
|    `ungetwc`     |        `wint_t ungetwc( wint_t ch, FILE *stream );`         |  将一个宽字符送回文件流   |

#### 有格式 I/O

##### `wscanf` 系列

|  函数名   |                           函数原型                           |              说明               |
| :-------: | :----------------------------------------------------------: | :-----------------------------: |
| `wscanf`  |         `int wscanf( const wchar_t *format, ... );`          | 从 `stdin` 读取格式化宽字符输入 |
| `fwscanf` |  `int fwscanf( FILE *stream, const wchar_t *format, ... );`  |  从文件流读取格式化宽字符输入   |
| `swscanf` | `int swscanf( const wchar_t *buffer, const wchar_t *format, ... );` |  从缓冲区读取格式化宽字符输入   |

##### `wprintf` 系列

|   函数名   |                           函数原型                           |           说明            |
| :--------: | :----------------------------------------------------------: | :-----------------------: |
| `wprintf`  |         `int wprintf( const wchar_t *format, ... );`         | 打印格式化输出到 `stdout` |
| `fwprintf` | `int fwprintf( FILE *stream, const wchar_t* format, ... );`  |  打印格式化输出到文件流   |
| `swprintf` | `int swprintf( wchar_t *buffer, size_t bufsz, const wchar_t* format, ... );` |  打印格式化输出到缓冲区   |

##### 格式化说明符与使用方式

| 格式化说明符 |         说明          |
| :----------: | :-------------------: |
|    `%lc`     |  对应 `wint_t` 类型   |
|    `%ls`     | 对应 `wchar_t *` 类型 |

`wscanf`/`wprintf` 系列中的 `format` 参数若是宽字符串字面量，亦须确保加上了对应的 `L` 标记。

`swprintf` 中的 `bufsz` 参数保证最多会写入 `bufsz - 1` 个宽字符，再加空终止符。

**注意：若 `wscanf` 系列函数在赋值首个接收参数前出现读取失败，返回值仍为 `EOF` 而非 `wchar.h` 中定义的宏 `WEOF` 。**

##### 示例

```c
#include <locale.h>
#include <wchar.h>
 
int main(void)
{
    char narrow_str[] = "z\u00df\u6c34\U0001f34c";
                    // 或 "zß水🍌"
                    // 或 "\x7a\xc3\x9f\xe6\xb0\xb4\xf0\x9f\x8d\x8c";
    wchar_t warr[29]; // 期待的字符串为 28 字节加 1 个空终止符
    setlocale(LC_ALL, "en_US.utf8");
    swprintf(warr, sizeof warr/sizeof *warr,
              L"Converted from UTF-8: '%s'", narrow_str);
    wprintf(L"%ls\n", warr);
}
```

#### 窄字符 `scanf`/`printf` 系列函数对宽字符（串）的处理

> 本节内容参考自[浅谈C中的wprintf和宽字符显示](https://blog.csdn.net/lovekatherine/article/details/1868724)。

窄字符之 `scanf`/`printf` 系列函数亦可使用 `%ls`/`%lc` 格式说明符来处理 `wchar_t *`/`wchar_t` 类型。但由于 `scanf`/`printf` 系列函数用于 byte stream，其输入/输出流中的每个字符占 `1 byte`；`wscanf`/`wprintf` 系列函数用于 wide stream，其输入/输出流中的每个字符多于 `1 byte`，故其有区别如下：

|            组合            |                             说明                             |
| :------------------------: | :----------------------------------------------------------: |
|  `scanf`/`printf` + `%s`   | `scanf`/`printf`将将指针对应缓冲区中的内容视作普通字符串，之后逐个字节输出 |
|  `scanf`/`printf` + `%ls`  | `scanf`/`printf` 将指针对应缓冲区中的内容视作宽字符串，按照 `locale` 的设定，将其中的每个字符隐式调用 `wcrtomb()` 函数将其转换成多字节字符串，之后逐个字节输出 |
| `wscanf`/`wprintf` + `%s`  | `wscanf`/`wprintf` 将指针对应缓冲区中的内容视作普通字符串，按照 `locale` 的设定，将其中的每个字符隐式调用 `mbrtowc()` 函数将其转换成宽字符串，之后逐个宽字符输出 |
| `wscanf`/`wprintf` + `%ls` | `wscanf`/`wprintf` 将指针对应缓冲区中的内容视作宽字符串，之后逐个宽字符输出 |

#### 文件读写

> 本节内容参考自 [Linux Manual Page](https://www.man7.org/linux/man-pages/man3/fopen.3.html) 和 [Visual Studio 2019 文档](https://docs.microsoft.com/en-us/cpp/c-runtime-library/reference/fopen-wfopen?view=vs-2019)。

C语言没有处理宽字符串或其他编码的特殊文件I/O函数，若需指定采用特殊编码读写文件，需采用一个gcc/msvc扩展，在读写模式字符串 `flag` 末尾加入额外的 `,ccs=encoding` 字段来指示读取文件所用编码。

当 `encoding` 为 UTF-8 时，应当使用 `,ccs=utf-8`。

##### 示例

```c
FILE *fp = fopen("test.in", "r, ccs=utf-8");
fgetws(s, 2047, fp);
wprintf(L"%ls\n", s);
fclose(fp);
```

### 其他相关函数

> 本节内容参考自中文 cppreference 的 [空终止宽字符串](https://zh.cppreference.com/w/c/string/wide)。

限于篇幅，以下只列出常用函数。

#### 字符串操作

|  函数名   |                           函数原型                           |                    说明                    |
| :-------: | :----------------------------------------------------------: | :----------------------------------------: |
| `wcscpy`  |   `wchar_t *wcscpy( wchar_t *dest, const wchar_t *src );`    |         将一个宽字符串复制给另一个         |
| `wcsncpy` | `wchar_t* wcsncpy( wchar_t* dest, const wchar_t* src, size_t count );` |  将一定量的宽字符从一个字符串复制到另一个  |
| `wcscat`  |   `wchar_t *wcscat( wchar_t *dest, const wchar_t *src );`    |      将一个宽字符串的副本后附于另一个      |
| `wcsncat` | `wchar_t *wcsncat( wchar_t *dest, const wchar_t *src, size_t count );` | 将一定量宽字符串从一个宽字符串后附到另一个 |

#### 字符串检验

|  函数名   |                           函数原型                           |                             说明                             |
| :-------: | :----------------------------------------------------------: | :----------------------------------------------------------: |
| `wcslen`  |            `size_t wcslen( const wchar_t *str );`            |                      返回宽字符串的长度                      |
| `wcscmp`  |   `int wcscmp( const wchar_t *lhs, const wchar_t *rhs );`    |                       比较两个宽字符串                       |
| `wcsncmp` | `int wcsncmp( const wchar_t* lhs, const wchar_t* rhs, size_t count );` |               比较来自两个宽字符串的一定量字符               |
| `wcsstr`  | `wchar_t* wcsstr( const wchar_t* dest, const wchar_t* src );` | 在 `dest` 所指的空终止宽字符串中，寻找 `src` 所指的空终止宽字符串的首次出现 |
| `wcstok`  | `wchar_t* wcstok( wchar_t* str, const wchar_t* delim, wchar_t **ptr );` | 寻找 `str` 所指向的空终止宽字符串中的下个记号。以 `delim` 所指向的空终止宽字符串鉴别分隔符 |

#### 宽字符数组操作

|  函数名   |                           函数原型                           |                   说明                   |
| :-------: | :----------------------------------------------------------: | :--------------------------------------: |
| `wmemcpy` | `wchar_t* wmemcpy( wchar_t* dest, const wchar_t* src, size_t count );` | 在两个不重叠的数组间复制一定数量的宽字符 |
| `wmemset` | `wchar_t *wmemset( wchar_t *dest, wchar_t ch, size_t count );` | 将给定的宽字符复制到宽字符数组的所有位置 |

## `locale` 设置

采用 `setlocale(LC_ALL, "chs");` 将当前 `locale` 设置为中文环境即可。
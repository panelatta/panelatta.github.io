---
categories:
- Reading Notes
- MySQL
date: '2020-12-12T20:08:26+08:00'
tags:
- MySQL
- Database
- SQL
- 读书笔记
title: MySQL相关笔记
toc: true
---

一些关于 SQL 及 MySQL 某些机制的相关笔记。

<!--more-->

## SQL 查询语句

![](https://cdn.jsdelivr.net/gh/panelatta/static-resources/img/image-20201213111128181.png)

### `select` 子句

`select` 子句用于在所有可能的列中，选择查询结果应当包含哪些列。

#### 命令格式

```
SELECT
[DISTINCT]/[ALL]	# 指定是否对行去重，默认为 ALL
					# 注意对行去重操作需要对数据进行排序，可能相当耗时
[column 1] ([AS] [alias 1]), [column 2] ([AS] [alias 2]), ...
					# [column] 指定列名或相关的操作，如调用函数、字符串、表达式等
					# [alias] 为列指定别名，显示为查询结果中列的标签
					# 可以显式地使用 [AS] 关键字阐明为列指定别名的意图，但通常情况下，这是不必要的
[FROM]				# 仅调用内建函数的情况下不需要使用 FROM 子句，如 SELECT DATABASE();
...					# 可添加其他子句，如 WHERE
```

### `from` 子句

`from` 子句定义查询中所使用的表，及其连接方式。

#### 命令格式

最普通的使用格式为：

```sql
SELECT [column 1], [column 2], ...
FROM [table 1], [table 2], ...
...
```

也可以在 `from` 子句中显式地指定表的别名，并在 `select` 子句中的列名中使用：

```sql
SELECT [t1.column1], [t1.column2], ...
FROM table_1 t1, [table 2] ([alias]), ...
```

`from` 子句也可指明表连接的方式：

```sql
SELECT ...
FROM [table_1] [INNER]/[LEFT (OUTER)]/[RIGHT (OUTER)]/[FULL (OUTER)]/[CROSS] [JOIN] [table_2]
```

#### 表的概念

表的概念包含如下三种：

- **永久表**：存储在数据库中，使用 `CREATE TABLE` 语句创建的表。
- **临时表**：子查询所返回的表。
- **虚拟表**：使用 `CREATE VIEW` 语句创建的视图。

以上三种表都可以在 `from` 子句中使用。

##### 子查询返回的表

子查询可以出现在 `select` 子句中的任何部分，使用圆括号进行标示。在 `from` 语句中，可以使用子查询返回的临时表进行查询，如：

```sql
SELECT e.emp_id, e.fname, e.lname
FROM (
	SELECT emp_id, fname, lname, start_date, title
	FROM employee
) e;
```

##### 视图

视图是存储在数据字典中的查询，行为表现得像一个表；视图内的数据字段都来源于真实的数据字段。视图只能用于查询，不能对数据进行增删改。

当对视图发出一个查询时，这个查询会被绑定到视图定义上，以执行最终查询。因此，视图总是显示最近的数据；当用户发出查询时，数据是数据库引擎通过 SQL 语句重建的。

视图的使用目的一般是为了对用户隐藏列，或者简化数据库设计。

###### 命令格式

```sql
CREATE VIEW [view_name] AS
SELECT ...		# 内容与 SELECT 子句相同
```

例：

```sql
CREATE VIEW employee_view AS
SELECT emp_id, fname, lname, YEAR(start_date) start_year
FROM employee;
```

之后可直接对视图 `employee_view` 执行查询：

```sql
SELECT emp_id, start_year
FROM employee_view;
```

### `where` 子句

`where` 子句用于在查询结果中过滤掉不感兴趣的行。

#### 命令格式

```sql
SELECT ...
FROM ...
WHERE ([NOT]) [CONDITION 1] ([AND/OR] ([NOT]) [CONDITION 2]) ...	# 这里的圆括号表示可选
```

类似其他语言，可以使用圆括号对条件进行分组。

#### 操作符

![](https://cdn.jsdelivr.net/gh/panelatta/static-resources/img/image-20201213162353465.png)

##### `between` 操作符

`between` 操作符用于同时限定范围的上下限，用法为 `between <下限> and <上限>` 。

`between` 的查询范围是闭区间。

##### `in` 操作符

`in` 操作符用于检查被查询的值是否属于一个有限集合。例如：

```sql
SELECT account_id, product_id, cust_id, avail_balance
FROM account
WHERE product_cd IN ('CHK', 'SAV', 'CD', 'MM');
```

等价于如下语句：

```sql
SELECT account_id, product_id, cust_id, avail_balance
FROM account
WHERE product_cd = 'CHK' OR product_cd = 'SAV' OR product_cd = 'CD' OR product_cd = 'MM';
```

`in` 操作符也可以被 `not` 修饰。

##### `like` 操作符

使用 `like` 操作符，可以使用通配符构建搜索表达式进行查询。

![](https://cdn.jsdelivr.net/gh/panelatta/static-resources/img/image-20201213163614714.png)

例如：

```sql
SELECT lname
FROM employee
WHERE lname LIKE '_a%a%'
```

##### `regexp` 操作符

`regexp` 操作符接受一个正则表达式做为搜索表达式进行查询。例如：

```sql
SELECT emp_id, fname, lname
FROM employee
WHERE lname REGEXP '^[FG]';
```

#### 对 `null` 的测试

`null` 有两个特性：

- 表达式的值可以为 `null` ，但测试 `<表达式> = null` 总会失败。
- 两个 `null` 值不能彼此判断为相等。

想要测试某个表达式的值是否为 `null`，可以使用`IS NULL` 操作符：

```sql
SELECT emp_id, fname, lname, superior_emp_id
FROM employee
WHERE superior_emp_id IS NULL
```

相应地，可以使用 `IS NOT NULL` 操作符来判断表达式的值是否不为 `NULL`。

需要注意的一点是，当进行普通的条件判断时，值为 `NULL` 的行可能不会出现在查询结果中；如这个例子中，想要查询所有 `superior_emp_id` 不为 6 的人：

```sql
SELECT emp_id, fname, lname, superior_emp_id
FROM employee
WHERE superior_emp_id != 6
```

将会遗漏某一行的 `superior_emp_id` 对应值为 `NULL` 的可能性。因此，为了查询所有 `superior_emp_id` 不为 6 的人，需要将对 `NULL` 的判断显式加入条件中：

```sql
SELECT emp_id, fname, lname, superior_emp_id
FROM employee
WHERE superior_emp_id != 6 AND superior_emp_id IS NOT NULL
```

#### 使用子查询

子查询的结果也可以做为 `where` 的条件。例如：

```sql
SELECT account_id, product_id, cust_id, avail_balance
FROM account
WHERE product_cd IN (
	SELECT product_cd
    FROM product
    WHERE product_type_cd = 'ACCOUNT'
);
```

### `group by` 和 `having` 子句

`group by` 子句根据列值对数据进行分组，`having` 子句对分组数据进行过滤，类似 `where` 子句。

#### 命令格式

```sql
SELECT ...
FROM ...
GROUP BY [column]
HAVING [condition]
```

### `order by` 子句

`order by` 子句根据某些列值或表达式的计算结果对数据进行排序。

#### 命令格式

```sql
SELECT [column 1], [column 2], ...
FROM ...
ORDER BY [column], ..., [expression], ..., [column id], ... ([ASC]/[DESC])
					# ASC 与 DESC 表示排列方式为升序/降序，默认为 ASC
```

`order by` 根据后面跟随的列名/表达式/列编号，逐个做为第 1 至第 k 关键字对结果进行排序。

`order by` 中使用的列编号是 `select` 中出现的列的顺序编号。

## 多表联查

### 内连接

内连接使用 `inner join` 标识。

#### 命令格式

```sql
SELECT ...
FROM [table 1] ([INNER]) [JOIN] [table 2]
ON [CONDITION]
```

如果 `ON` 之后的限定条件类似 `table_1.column = table_2.column`，且两个 `column` 相同，此时可以改写为

```sql
SELECT ...
FROM [table 1] ([INNER]) [JOIN] [table 2]
USING [column]
```

多数情况下，数据库查询引擎能够接受类似如下比较老的内连接语句：

```sql
SELECT e.fname, e.lname, d.name
FROM employee e, department d
WHERE e.dept_id = d.dept_id
```

这种语法在 `FROM` 后将表用逗号隔开，并将连接条件写在 `WHERE` 内。这种语法在处理较为复杂的多表联查时过于复杂，且难以分清 `WHERE` 后的条件究竟是连接条件还是过滤条件，也不易于指明连接类型。如以下代码：

![](https://cdn.jsdelivr.net/gh/panelatta/static-resources/img/image-20201213172814003.png)

在这里使用三表联查，同时 `WHERE` 后还有其他过滤条件，显得十分混乱。使用 `JOIN` 形式书写的查询代码如下：

![](https://cdn.jsdelivr.net/gh/panelatta/static-resources/img/image-20201213172912884.png)

立刻变得清晰许多。

### 多于两个表的联查

可以对多于两个表进行联查，并且可以对每个表采用不同的连接类型。

#### 命令格式

```sql
SELECT ...
FROM [table 1] ([INNER]/[LEFT (OUTER)]/[RIGHT (OUTER)]/[FULL (OUTER)]/[CROSS]) [JOIN] [table 2]
ON [CONDITION]
(([INNER]/[LEFT (OUTER)]/[RIGHT (OUTER)]/[FULL (OUTER)]/[CROSS]) [JOIN] [table 3]
ON [CONDITION])
...
```

如以下代码所示：

![](https://cdn.jsdelivr.net/gh/panelatta/static-resources/img/image-20201213172912884.png)

#### `STRAIGHT_JOIN` 关键字

一般而言，多个表连接的具体顺序在查询过程中由优化器决定。如果想要手工指定连接方式，可以使用 `STRAIGHT_JOIN` 关键字。

![](https://cdn.jsdelivr.net/gh/panelatta/static-resources/img/image-20201213173626743.png)

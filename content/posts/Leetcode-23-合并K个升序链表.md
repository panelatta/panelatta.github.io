---
categories:
- Programming Contest
- Leetcode
- Linked List
date: '2020-11-27T16:52:26+08:00'
tags:
- Leetcode
- Hard
- 链表
- 优先队列
title: '[Leetcode 23]合并K个升序链表（优先队列）'
toc: true
---

第一次做链表相关的题，虽然是个水题，还是记录一下。

<!--more-->

## 题面

给你一个链表数组，每个链表都已经按升序排列。

请你将所有链表合并到一个升序链表中，返回合并后的链表。

**示例 1：**

>**输入**：lists = [[1,4,5],[1,3,4],[2,6]]
>**输出**：[1,1,2,3,4,4,5,6]
>**解释**：链表数组如下：
>[
>  1->4->5,
>  1->3->4,
>  2->6
>]
>将它们合并到一个有序链表中得到。
>1->1->2->3->4->4->5->6

**示例 2：**

>**输入**：lists = []
>**输出**：[]

**示例 3：**

> 输入：lists = [[]]
> 输出：[]

提示：

- k == `lists.length`
- 0 <= k <= 10^4
- 0 <= `lists[i].length` <= 500
- -10^4 <= `lists[i][j]` <= 10^4
- `lists[i]` 按 升序 排列
- `lists[i].length` 的总和不超过 10^4

## 题解

用优先队列维护 $k$ 个元素中的当前最小值即可。假设所有链表长度均为 $n$，因为优先队列单次插入/弹出复杂度为 $O({\rm log}k)$，故时间复杂度为 $O(nk{\rm log}k)$。

> **注意**：`vector` 内不能存放元素的引用，只能存放指针。

## 代码

```c++
/**
 * Definition for singly-linked list.
 * struct ListNode {
 *     int val;
 *     ListNode *next;
 *     ListNode() : val(0), next(nullptr) {}
 *     ListNode(int x) : val(x), next(nullptr) {}
 *     ListNode(int x, ListNode *next) : val(x), next(next) {}
 * };
 */
class Solution {
public:
    struct cmp {
        bool operator () (const ListNode *a, const ListNode *b) {
            return a->val > b->val;
        }
    };
    const int INF = 0x3f3f3f3f;

    ListNode* mergeKLists(vector<ListNode*>& lists) {
        ListNode head(INF, nullptr);
        ListNode *now = &head;
        priority_queue<ListNode *, vector<ListNode *>, cmp> q;
        
        int k = lists.size();
        for(int i = 0; i < k; i++) {
            if(lists[i] != nullptr) {
                q.push(lists[i]);
            }
        }
        
        while(!q.empty()) {
            now->next = q.top();
            now = now->next;
            q.pop();
            if(now->next != nullptr) {
                q.push(now->next);
            }
        }

        return head.next;
    }
};
```

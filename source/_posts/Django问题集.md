---
title: Django问题集
date: 2020-04-30 20:10:37
tags: Django
categories:
  - Back End
  - Django
---

专门开篇文章记录一下学习 Django 过程中遇到的各种问题。

<!--more-->

## 环境配置问题

### AttributeError: module 'django.conf.global_settings' has no attribute 'TEMPLATE_CONTEXT_PROCESSORS'

出处：https://github.com/gadventures/django-fsm-admin/issues/76

> https://stackoverflow.com/questions/39315348/cannot-import-name-template-context-processors
>
> From link above, stated that:
>  `It's already deprecated in Django 1.8 and removed completely in Django 1.10`
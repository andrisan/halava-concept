# Core Concepts: Order Type Determination

> **Module:** Business Logic
> **Version:** v1.0
> **Status:** Active
>
> **Referenced By:** [[order-management]] · [[restaurant-ops]]

This document outlines the core business logic for how an order's type is determined based on the channel it originates from and how it is paid for. This logic applies across all Halava operations, including general shops and restaurants.

---

### **I. Shop Operations**

For general retail shops, orders are typically either online (pre-paid) or processed immediately at the physical counter.

| Payment Choice       | Order Type             | Processing                       |
| :------------------- | :--------------------- | :------------------------------- |
| Online Pre-paid      | Online Order           | Order Management                 |
| Immediate at Counter | POS Order (Walk-in Sale) | POS System (Immediate Transaction) |

---

### **II. Restaurant Operations**

For restaurants, payment choice determines if the order is handled as a digital order (potentially for dine-in at a desired time) or requires preparation after counter payment.

| Payment Choice       | Order Type                                     | Processing                             |
| :------------------- | :--------------------------------------------- | :------------------------------------- |
| Online Pre-paid      | Dine-in Pre-order (with desired arrival time)  | Order Management                       |
| Immediate at Counter | Prepared Order                                 | POS System (with Kitchen Integration)  |

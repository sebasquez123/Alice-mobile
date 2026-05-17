# Alice Mobile - Lightweight Schema (Aligned with ERD)

---

## ✅ users

```json
{
  "user_id": 1,
  "email": "user@example.com",
  "name": "Juan Pérez",
  "phone_number": "+34 123 456 789",
  "is_phone_confirmed": true,
  "residential_address": "Calle Principal 123",
  "created_at": "2026-05-10T08:00:00Z",
  "updated_at": "2026-05-17T14:00:00Z"
}
```

---

## ✅ roles

```json
{
  "role_id": 1,
  "name": "admin"
}
```

---

## ✅ permissions

```json
{
  "permission_id": 1,
  "name": "admin_access",
  "description": "Full admin access"
}
```

---

## ✅ user_roles

```json
{
  "id": 1,
  "user_id": 1,
  "role_id": 1
}
```

---

## ✅ role_permissions

```json
{
  "id": 1,
  "role_id": 1,
  "permission_id": 1
}
```

---

## ✅ categories

```json
{
  "category_id": 1,
  "name": "Cakes"
}
```

---

## ✅ standard_products

```json
{
  "standard_product_id": 1,
  "title": "Chocolate Cake",
  "description": "Classic chocolate cake",
  "image_url": "https://...",
  "category_id": 1,
  "cost": 25.00,
  "created_at": "2026-05-10T00:00:00Z",
  "updated_at": "2026-05-17T15:45:00Z"
}
```

---

## ✅ custom_products

```json
{
  "custom_product_id": 1,
  "order_id": 1,
  "title": "Custom Birthday Cake",
  "animation_name": "spiderman_theme",
  "amount_portions": 10,
  "coverage_type_id": 1,
  "cake_flavor_id": 1,
  "filling_flavor_id": 1,
  "details": "Red and blue design",
  "cost": 45.00,
  "category": "birthday",
  "created_at": "2026-05-10T00:00:00Z",
  "updated_at": "2026-05-17T15:45:00Z"
}
```

---

## ✅ custom_product_images

```json
{
  "id": 1,
  "custom_product_id": 1,
  "image_url": "https://..."
}
```

---

## ✅ coverage_types

```json
{
  "coverage_type_id": 1,
  "name": "Fondant"
}
```

---

## ✅ cake_flavors

```json
{
  "cake_flavor_id": 1,
  "name": "Chocolate"
}
```

---

## ✅ filling_flavors

```json
{
  "filling_flavor_id": 1,
  "name": "Strawberry"
}
```

---

## ✅ orders

```json
{
  "order_id": 1,
  "user_id": 1,
  "assisted_by_id": 2,
  "order_state": "pending",
  "delivery_date": "2026-05-20",
  "delivery_address": "Calle Principal 123",
  "total_items": 2,
  "additional_cost_details": "Extra decoration",
  "dispatch_cost": 5.00,
  "total_order": 50.00,
  "initial_installment": 20.00,
  "installment_mean": "cash",
  "current_balance": 30.00,
  "created_at": "2026-05-17T10:30:00Z",
  "updated_at": "2026-05-17T14:00:00Z"
}
```

---

## ✅ order_standard_products

```json
{
  "id": 1,
  "order_id": 1,
  "standard_product_id": 1,
  "quantity": 1,
  "unit_price": 25.00
}
```

---

## ✅ ads

```json
{
  "ad_id": 1,
  "standard_product_id": 1,
  "image_url": ["https://..."],
  "description": "Promo cake",
  "category_id": 1,
  "hashtags": ["#cake", "#promo"],
  "created_at": "2026-05-10T00:00:00Z",
  "updated_at": "2026-05-17T15:45:00Z"
}
```

---

## ✅ mostrarios

```json
{
  "mostrario_id": 1,
  "image_url": ["https://..."],
  "description": "Promo cake",
  "category_id": 1,
  "created_at": "2026-05-10T00:00:00Z",
  "updated_at": "2026-05-17T15:45:00Z",
  "deleted_at": "2026-05-17T15:45:00Z"
}
```

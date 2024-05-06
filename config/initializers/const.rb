PRODUCT_STATUS = {
  active: 'active',
  inactive: 'inactive',
}.freeze

USER_STATUS = {
  active: 'active',
  inactive: 'inactive',
}.freeze

USER_TYPE = {
  customer: 'customer',
  admin: 'admin',
}.freeze

ORDER_STATUS = {
  pending: 'pending',
  processing: 'processing',
  canceled: 'canceled',
  done: 'done'
}.freeze

PAYMENT_STATUS = {
  pending: 'pending',
  paid: 'paid',
  refunded: 'refunded',
  failed: 'failed'
}.freeze

PAYMENT_FLOW = {
  redirect: 'redirect',
  cash: 'cash',
  va: 'va',
  retail: 'retail',
  qris: 'qris',
  cc: 'cc',
}.freeze
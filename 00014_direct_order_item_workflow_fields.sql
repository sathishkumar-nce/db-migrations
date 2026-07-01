-- +goose Up
-- +goose StatementBegin
ALTER TABLE direct_order_items
ADD COLUMN IF NOT EXISTS customer_width_in_inches NUMERIC(10,2),
ADD COLUMN IF NOT EXISTS customer_length_in_inches NUMERIC(10,2),
ADD COLUMN IF NOT EXISTS customer_width_in_mm NUMERIC(10,2),
ADD COLUMN IF NOT EXISTS customer_length_in_mm NUMERIC(10,2),
ADD COLUMN IF NOT EXISTS corner_radius_and_notes TEXT;

UPDATE direct_orders
SET order_status = 'manufactured'
WHERE order_status = 'packed';

ALTER TABLE direct_orders
ALTER COLUMN order_status SET DEFAULT 'confirmed';

ALTER TABLE direct_orders
DROP CONSTRAINT IF EXISTS valid_order_status;

ALTER TABLE direct_orders
ADD CONSTRAINT valid_order_status CHECK (
    order_status IN ('confirmed', 'manufactured', 'on-hold', 'forwarded', 'cancelled', 'returned', 'other-issues')
);
-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
UPDATE direct_orders
SET order_status = 'packed'
WHERE order_status = 'manufactured';

ALTER TABLE direct_orders
DROP CONSTRAINT IF EXISTS valid_order_status;

ALTER TABLE direct_orders
ADD CONSTRAINT valid_order_status CHECK (
    order_status IN ('confirmed', 'packed', 'on-hold', 'forwarded', 'cancelled', 'returned', 'other-issues')
);

ALTER TABLE direct_order_items
DROP COLUMN IF EXISTS customer_width_in_inches,
DROP COLUMN IF EXISTS customer_length_in_inches,
DROP COLUMN IF EXISTS customer_width_in_mm,
DROP COLUMN IF EXISTS customer_length_in_mm,
DROP COLUMN IF EXISTS corner_radius_and_notes;
-- +goose StatementEnd

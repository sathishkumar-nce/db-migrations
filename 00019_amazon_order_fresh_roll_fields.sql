-- +goose Up
-- +goose StatementBegin
ALTER TABLE amazon_orders
ADD COLUMN IF NOT EXISTS is_fresh_roll BOOLEAN NOT NULL DEFAULT FALSE,
ADD COLUMN IF NOT EXISTS is_fresh_roll_addressed BOOLEAN NOT NULL DEFAULT FALSE,
ADD COLUMN IF NOT EXISTS fresh_roll_addressed_action TEXT;

CREATE INDEX IF NOT EXISTS idx_amazon_orders_is_fresh_roll
ON amazon_orders(is_fresh_roll);

CREATE INDEX IF NOT EXISTS idx_amazon_orders_is_fresh_roll_addressed
ON amazon_orders(is_fresh_roll_addressed);
-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
SELECT 1;
-- +goose StatementEnd

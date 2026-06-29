-- +goose Up
-- +goose StatementBegin
ALTER TABLE amazon_orders
DROP COLUMN IF EXISTS whatsapp_sent,
DROP COLUMN IF EXISTS email_sent;

-- +goose StatementEnd
-- +goose Down
-- +goose StatementBegin
SELECT 1;
-- +goose StatementEnd

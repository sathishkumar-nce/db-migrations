-- +goose Up
-- +goose StatementBegin
ALTER TABLE direct_orders
DROP COLUMN IF EXISTS invoice_number,
DROP COLUMN IF EXISTS tracking_url,
DROP COLUMN IF EXISTS ewaybill;

-- +goose StatementEnd
-- +goose Down
-- +goose StatementBegin
SELECT 1;
-- +goose StatementEnd

-- +goose Up
-- +goose StatementBegin
ALTER TABLE direct_orders
DROP CONSTRAINT IF EXISTS direct_orders_valid_courier_type;

-- +goose StatementEnd
-- +goose Down
-- +goose StatementBegin
SELECT 1;
-- +goose StatementEnd

-- +goose Up
-- +goose StatementBegin
ALTER TABLE interakt_settings
ADD COLUMN IF NOT EXISTS test_number VARCHAR(32) NOT NULL DEFAULT '';

UPDATE interakt_settings
SET test_number = ''
WHERE test_number IS NULL;
-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
SELECT 1;
-- +goose StatementEnd

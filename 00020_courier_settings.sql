-- +goose Up
-- +goose StatementBegin
CREATE TABLE IF NOT EXISTS courier_settings (
    state_key VARCHAR(32) PRIMARY KEY,
    settings JSONB NOT NULL,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
DROP TABLE IF EXISTS courier_settings;
-- +goose StatementEnd

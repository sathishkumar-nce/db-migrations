-- +goose Up
-- +goose StatementBegin
CREATE TABLE IF NOT EXISTS interakt_settings (
    state_key VARCHAR(32) PRIMARY KEY,
    enabled BOOLEAN NOT NULL DEFAULT FALSE,
    mode VARCHAR(16) NOT NULL DEFAULT 'prod',
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP NOT NULL DEFAULT NOW(),
    CONSTRAINT chk_interakt_settings_mode CHECK (mode IN ('test', 'prod'))
);

INSERT INTO interakt_settings (state_key, enabled, mode)
VALUES ('global', FALSE, 'prod')
ON CONFLICT (state_key) DO NOTHING;
-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
SELECT 1;
-- +goose StatementEnd

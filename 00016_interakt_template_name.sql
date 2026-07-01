-- +goose Up
-- +goose StatementBegin
ALTER TABLE interakt_settings
ADD COLUMN IF NOT EXISTS template_name VARCHAR(120) NOT NULL DEFAULT 'amzmrclearorderconfirmation_v2';

UPDATE interakt_settings
SET template_name = 'amzmrclearorderconfirmation_v2'
WHERE COALESCE(BTRIM(template_name), '') = '';
-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
SELECT 1;
-- +goose StatementEnd

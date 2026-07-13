-- +goose Up
-- +goose StatementBegin
CREATE TABLE IF NOT EXISTS order_review_intents (
    amazon_order_id VARCHAR(50) PRIMARY KEY
        REFERENCES amazon_orders(amazon_order_id) ON DELETE CASCADE,
    review_confidence INT NOT NULL DEFAULT 0,
    review_request_status VARCHAR(24) NOT NULL DEFAULT 'not-requested',
    updated_by VARCHAR(100),
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP NOT NULL DEFAULT NOW(),
    CONSTRAINT chk_order_review_confidence CHECK (review_confidence BETWEEN 0 AND 100),
    CONSTRAINT chk_order_review_request_status CHECK (review_request_status IN ('not-requested', 'requested', 'received-review'))
);

ALTER TABLE order_review_intents
ADD COLUMN IF NOT EXISTS review_request_status VARCHAR(24) NOT NULL DEFAULT 'not-requested';

DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1
        FROM pg_constraint
        WHERE conname = 'chk_order_review_request_status'
    ) THEN
        ALTER TABLE order_review_intents
        ADD CONSTRAINT chk_order_review_request_status
        CHECK (review_request_status IN ('not-requested', 'requested', 'received-review'));
    END IF;
END $$;

CREATE TABLE IF NOT EXISTS review_followup_state_settings (
    state_code VARCHAR(8) PRIMARY KEY,
    state_name VARCHAR(100) NOT NULL UNIQUE,
    followup_days INT NOT NULL DEFAULT 7,
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP NOT NULL DEFAULT NOW(),
    CONSTRAINT chk_review_followup_days CHECK (followup_days >= 0 AND followup_days <= 120)
);

INSERT INTO review_followup_state_settings (state_code, state_name, followup_days)
VALUES
    ('AN', 'Andaman & Nicobar Islands', 7),
    ('AP', 'Andhra Pradesh', 7),
    ('AR', 'Arunachal Pradesh', 7),
    ('AS', 'Assam', 7),
    ('BR', 'Bihar', 7),
    ('CH', 'Chandigarh', 7),
    ('CG', 'Chhattisgarh', 7),
    ('DN', 'Dadra & Nagar Haveli and Daman & Diu', 7),
    ('DL', 'Delhi', 7),
    ('GA', 'Goa', 7),
    ('GJ', 'Gujarat', 7),
    ('HR', 'Haryana', 7),
    ('HP', 'Himachal Pradesh', 7),
    ('JK', 'Jammu & Kashmir', 7),
    ('JH', 'Jharkhand', 7),
    ('KA', 'Karnataka', 7),
    ('KL', 'Kerala', 7),
    ('LA', 'Ladakh', 7),
    ('LD', 'Lakshadweep', 7),
    ('MH', 'Maharashtra', 7),
    ('ML', 'Meghalaya', 7),
    ('MN', 'Manipur', 7),
    ('MP', 'Madhya Pradesh', 7),
    ('MZ', 'Mizoram', 7),
    ('NL', 'Nagaland', 7),
    ('OD', 'Odisha', 7),
    ('PB', 'Punjab', 7),
    ('PY', 'Puducherry', 7),
    ('RJ', 'Rajasthan', 7),
    ('SK', 'Sikkim', 7),
    ('TN', 'Tamil Nadu', 7),
    ('TR', 'Tripura', 7),
    ('TS', 'Telangana', 7),
    ('UK', 'Uttarakhand', 7),
    ('UP', 'Uttar Pradesh', 7),
    ('WB', 'West Bengal', 7)
ON CONFLICT (state_code) DO NOTHING;

CREATE INDEX IF NOT EXISTS idx_order_review_intents_confidence
ON order_review_intents(review_confidence DESC);

CREATE INDEX IF NOT EXISTS idx_order_review_intents_request_status
ON order_review_intents(review_request_status);

CREATE INDEX IF NOT EXISTS idx_review_followup_state_name
ON review_followup_state_settings(LOWER(state_name));
-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
SELECT 1;
-- +goose StatementEnd

CREATE TABLE medical_histories (
    id SERIAL PRIMARY KEY,
    admitted_at TIMESTAMP,
    patient_id INTEGER REFERENCES patients (id) ON DELETE CASCADE,
    status varchar(225) NOT NULL
);

CREATE TABLE patients (
    id SERIAL PRIMARY KEY,
    name varchar(225) NOT NULL,
    date_of_birth DATE NOT NULL
);

CREATE TABLE invoices (
    id SERIAL PRIMARY KEY,
    total_amount DECIMAL NOT NULL,
    generated_at TIMESTAMP,
    payed_at TIMESTAMP,
    medical_history_id INTEGER REFERENCES medical_histories (id) ON DELETE CASCADE
);

CREATE TABLE invoice_items (
    id SERIAL PRIMARY KEY,
    unit_price DECIMAL NOT NULL,
    quantity INTEGER NOT NULL,
    total_price DECIMAL NOT NULL,
    invoice_id INTEGER REFERENCES invoices (id) ON DELETE CASCADE,
    treatment_id INTEGER REFERENCES treatments (id) ON DELETE CASCADE,
);

CREATE TABLE treatments (
    id SERIAL PRIMARY KEY,
    type varchar(225) NOT NULL,
    name varchar(225) NOT NULL
);

-- Create a join table for the many to many relationship between the treatments and medical_histories tables.

CREATE TABLE medical_histories_treatment (
    medical_history_id INTEGER REFERENCES medical_histories (id) ON DELETE CASCADE,
    treatment_id INTEGER REFERENCES treatments (id) ON DELETE CASCADE
);

-- Index clauses

CREATE INDEX patients_id_medical ON medical_histories (patient_id);
CREATE INDEX invoices_medical_history_id ON invoices (medical_history_id);
CREATE INDEX invoice_items_invoice_id ON invoice_items (invoice_id);
CREATE INDEX invoice_items_treatment_id ON invoice_items (treatment_id);
CREATE INDEX medical_histories_has_treatments_medical_history_id ON medical_histories_has_treatments (medical_history_id);
CREATE INDEX medical_histories_has_treatments_treatment_id ON medical_histories_has_treatments (treatment_id);

SELECT * FROM tutores;
INSERT INTO tutores (nombre, telefono) VALUES
('Pedro Pablo' , '9999999999'),
('Juan Villa', '888888888')



SELECT * FROM tutores;
UPDATE tutores
SET telefono = '888-1929'
WHERE nombre = 'Carlos Mendoza';

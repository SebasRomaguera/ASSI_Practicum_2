-- Crear la base de datos y seleccionarla
CREATE DATABASE borjamoll;
USE borjamoll;

-- Crear la tabla de Teacher
CREATE TABLE Teacher (
  id INTEGER PRIMARY KEY,
  name VARCHAR(250),
  surname VARCHAR(250),
  email VARCHAR(250)
);

-- Crear la tabla de Company
CREATE TABLE Company (
  id INTEGER PRIMARY KEY,
  name VARCHAR(250),
  email VARCHAR(250)
);

-- Crear la tabla de Employee, con una clave foránea que hace referencia a Company
CREATE TABLE Employee (
  id INTEGER PRIMARY KEY,
  name VARCHAR(250),
  surname VARCHAR(250),
  email VARCHAR(250),
  phone VARCHAR(20),
  company_id INTEGER,
  FOREIGN KEY (company_id) REFERENCES Company(id)
);

-- Crear la tabla de Student, con claves foráneas que hacen referencia a Teacher y Employee
CREATE TABLE Student (
  id INTEGER PRIMARY KEY,
  name VARCHAR(250),
  surname VARCHAR(250),
  email VARCHAR(250),
  phone VARCHAR(20),
  teacher_id INTEGER,
  employee_id INTEGER,
  FOREIGN KEY (teacher_id) REFERENCES Teacher(id),
  FOREIGN KEY (employee_id) REFERENCES Employee(id)
);

-- Insertar datos en la tabla Teacher
INSERT INTO Teacher (id, name, surname, email) VALUES
(1, 'Antonia', 'Gonzalez', 'antonia@cifpfbmoll.eu'),
(2, 'Josep', 'Martinez', 'josep@cifpfbmoll.eu'),
(3, 'Carla', 'Lorenzo', 'carla@cifpfbmoll.eu'),
(4, 'Laura', 'Gil', 'laura@cifpfbmoll.eu');

-- Insertar datos en la tabla Company
INSERT INTO Company (id, name, email) VALUES
(1, 'Barcelo', 'info@barcelo.com'),
(2, 'AirEuropa', 'contact@aireuropa.com'),
(3, 'Globalia', 'contact@globalia.com'),
(4, 'Iberostar', 'info@iberostar.com');

-- Insertar datos en la tabla Employee
INSERT INTO Employee (id, name, surname, email, phone, company_id) VALUES
(1, 'Aina', 'Lopez', 'aina@barcelo.com', '600111222', 1),
(2, 'Jaume', 'Pons', 'jaume@aireuropa.com', '600333444', 2),
(3, 'Marta', 'Perez', 'marta@globalia.com', NULL, 3), -- Este empleado no tiene teléfono
(4, 'Toni', 'Garcia', 'toni@barcelo.com', '600777888', 1),
(5, 'Manuel', 'Santos', 'manuel@iberostar.com', '601111111', 4),
(6, 'Nuria', 'Lopez', 'nuria@barcelo.com', '601222222', 1);

-- Insertar datos en la tabla Student
INSERT INTO Student (id, name, surname, email, phone, teacher_id, employee_id) VALUES
(1, 'Maria', 'Segura', 'maria@cifpfbmoll.eu', '650111111', 1, 1),
(2, 'Joan', 'Ramirez', 'joan@cifpfbmoll.eu', '650222222', 2, 2),
(3, 'Lucia', 'Ortega', 'lucia@cifpfbmoll.eu', '650333333', 1, 3),
(4, 'Pere', 'Sastre', 'pere@cifpfbmoll.eu', '650444444', 3, 4),
(5, 'Ana', 'Molina', 'ana@cifpfbmoll.eu', '650555555', 2, 1),
(6, 'Carlos', 'Navarro', 'carlos@cifpfbmoll.eu', '650666666', 3, 2),
(7, 'Laura', 'Diaz', 'laura@cifpfbmoll.eu', '650777888', 2, 3),
(8, 'Luis', 'Fernandez', 'luis@cifpfbmoll.eu', NULL, 4, 5), -- Este estudiante no tiene teléfono
(9, 'Sara', 'Marquez', 'sara@cifpfbmoll.eu', '650999000', 1, 6),
(10, 'Andrea', 'Soler', 'andrea@cifpfbmoll.eu', '650111999', 3, 2),
(11, 'Pablo', 'Lopez', 'pablo@cifpfbmoll.eu', '650112233', 1, 2); -- Cumple con teacher_id = 1 y employee_id = 2

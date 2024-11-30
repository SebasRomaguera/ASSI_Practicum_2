--JOIN
-- 1. Muestra el nombre y apellido de los estudiantes junto con el nombre de su empresa.
SELECT CONCAT(Student.name, ' ', Student.surname) AS DATOS_ESTUDIANTE, Company.name
FROM Student
JOIN Employee ON Student.employee_id = Employee.id
JOIN Company ON Employee.company_id = Company.id;

-- 2. Lista de empleados con su nombre, apellido y nombre de la empresa, pero solo los asignados a un estudiante.
SELECT Employee.name, Employee.surname, Company.name
FROM Employee
JOIN Company ON Employee.company_id = Company.id;

-- 3. Nombre de estudiantes, su email, el nombre de su maestro y el nombre de la empresa donde trabaja su empleado.
SELECT Student.name, Student.email, Teacher.name AS Maestro, Company.name AS Empresa
FROM Student
JOIN Teacher ON Student.teacher_id = Teacher.id
JOIN Employee ON Student.employee_id = Employee.id
JOIN Company ON Employee.company_id = Company.id;
--LEFT JOIN
-- 1. Lista de estudiantes con nombres, apellidos, teléfono y su empresa (incluyendo sin empresa).
SELECT Student.name, Student.surname, Student.phone, Company.name AS Empresa
FROM Student
LEFT JOIN Employee ON Student.employee_id = Employee.id
LEFT JOIN Company ON Employee.company_id = Company.id;

-- 2. Todos los empleados con su nombre, apellido, teléfono, y si están asociados a algún estudiante.
SELECT Employee.name, Employee.surname, Employee.phone, Student.name AS Estudiante
FROM Employee
LEFT JOIN Student ON Employee.id = Student.employee_id;

-- 3. Profesores y los estudiantes bajo su tutela (incluyendo profesores sin estudiantes).
SELECT Teacher.name AS Profesor, Student.name AS Estudiante
FROM Teacher
LEFT JOIN Student ON Teacher.id = Student.teacher_id;
--RIGHT JOIN
-- 1. Lista de empleados con su nombre, apellido, y nombre de los estudiantes asociados (incluye empleados sin estudiantes).
SELECT Employee.name, Employee.surname, Student.name AS Estudiante
FROM Student
RIGHT JOIN Employee ON Student.employee_id = Employee.id;

-- 2. Lista de empleados, su empresa y los estudiantes asociados (incluye empleados sin estudiantes).
SELECT Employee.name AS Empleado, Company.name AS Empresa, Student.name AS Estudiante
FROM Employee
RIGHT JOIN Company ON Employee.company_id = Company.id
RIGHT JOIN Student ON Student.employee_id = Employee.id;

-- 3. Todas las empresas con los nombres de empleados y estudiantes asociados (incluye empresas sin empleados o estudiantes).
SELECT Company.name AS Empresa, Employee.name AS Empleado, Student.name AS Estudiante
FROM Company
RIGHT JOIN Employee ON Company.id = Employee.company_id
RIGHT JOIN Student ON Student.employee_id = Employee.id;
--FULL JOIN
-- 1. Lista de estudiantes con el nombre de su profesor y empresa (incluyendo sin empresa o profesor).
SELECT Student.name AS Estudiante, Teacher.name AS Profesor, Company.name AS Empresa
FROM Student
LEFT JOIN Teacher ON Student.teacher_id = Teacher.id
LEFT JOIN Employee ON Student.employee_id = Employee.id
LEFT JOIN Company ON Employee.company_id = Company.id
UNION
SELECT Student.name AS Estudiante, Teacher.name AS Profesor, Company.name AS Empresa
FROM Student
RIGHT JOIN Teacher ON Student.teacher_id = Teacher.id
RIGHT JOIN Employee ON Student.employee_id = Employee.id
RIGHT JOIN Company ON Employee.company_id = Company.id;

-- 2. Empresas y estudiantes asociados, mostrando también empresas sin estudiantes y estudiantes sin empresa.
SELECT Company.name AS Empresa, Student.name AS Estudiante
FROM Student
LEFT JOIN Employee ON Student.employee_id = Employee.id
LEFT JOIN Company ON Employee.company_id = Company.id
UNION
SELECT Company.name AS Empresa, Student.name AS Estudiante
FROM Student
RIGHT JOIN Employee ON Student.employee_id = Employee.id
RIGHT JOIN Company ON Employee.company_id = Company.id;

-- 3. Todos los empleados y su empresa, junto con los estudiantes asociados (incluye empleados sin estudiantes y estudiantes sin empleados).
SELECT Employee.name AS Empleado, Company.name AS Empresa, Student.name AS Estudiante
FROM Employee
LEFT JOIN Company ON Employee.company_id = Company.id
LEFT JOIN Student ON Employee.id = Student.employee_id
UNION
SELECT Employee.name AS Empleado, Company.name AS Empresa, Student.name AS Estudiante
FROM Student
RIGHT JOIN Employee ON Student.employee_id = Employee.id
RIGHT JOIN Company ON Employee.company_id = Company.id;
--GROUP BY
-- 1. Número de empleados por empresa.
SELECT COUNT(Employee.id) AS Numero_empleados, Company.name AS Empresa
FROM Employee
JOIN Company ON Employee.company_id = Company.id
GROUP BY Company.name;

-- 2. Número de estudiantes asignados a empleados de cada empresa.
SELECT COUNT(Student.id) AS Numero_estudiantes, Company.name AS Empresa
FROM Student
JOIN Employee ON Student.employee_id = Employee.id
JOIN Company ON Employee.company_id = Company.id
GROUP BY Company.name;

-- 3. Total de empleados por empresa y promedio de estudiantes asociados a cada empleado.
SELECT Company.name AS Empresa, COUNT(Employee.id) AS Total_empleados, AVG(suma_estudiantes) AS Media_estudiantes_empleados
FROM Company
LEFT JOIN Employee ON Company.id = Employee.company_id
LEFT JOIN (
    SELECT employee_id, COUNT(id) AS suma_estudiantes
    FROM Student
    GROUP BY employee_id
) AS estudiantes_summario ON Employee.id = estudiantes_summario.employee_id
GROUP BY Company.name;
--HAVING
-- 1. Muestra todos los empleados cuya empresa tiene más de 2 empleados asignados, utilizando HAVING.
SELECT Company.name, COUNT(Employee.id) AS Numero_empleados
FROM Employee
JOIN Company ON Employee.company_id = Company.id
GROUP BY Company.name
HAVING COUNT(Employee.id) > 2;

-- 2. Muestra los profesores que tienen asignados más de 2 estudiantes, utilizando HAVING.
SELECT Teacher.name, COUNT(Student.id) AS Numero_estudiantes
FROM Teacher
JOIN Student ON Teacher.id = Student.teacher_id
GROUP BY Teacher.name
HAVING COUNT(Student.id) > 2;

-- 3. Consulta todas las empresas con el número de empleados que tienen, pero filtra solo aquellas que tienen más de 1 empleado.
SELECT Company.name, COUNT(Employee.id) AS Numero_empleados
FROM Company
JOIN Employee ON Company.id = Employee.company_id
GROUP BY Company.name
HAVING COUNT(Employee.id) > 1;

-- 4. Obtén una lista de los empleados que están asociados a más de 2 estudiantes, filtrando con HAVING.
SELECT Employee.name, COUNT(Student.id) AS Numero_estudiantes
FROM Employee
JOIN Student ON Employee.id = Student.employee_id
GROUP BY Employee.name
HAVING COUNT(Student.id) > 2;

-- 5. Muestra los estudiantes y el número de profesores que los supervisan, filtrando aquellos con más de 1 maestro.
SELECT Student.name, COUNT(Teacher.id) AS Numero_profesores
FROM Student
JOIN Teacher ON Student.teacher_id = Teacher.id
GROUP BY Student.name
HAVING COUNT(Teacher.id) > 1;
--EXISTS
-- 1. Muestra todos los estudiantes que tienen asignado al menos un profesor, utilizando EXISTS.
SELECT Student.name
FROM Student
WHERE EXISTS (
    SELECT 1
    FROM Teacher
    WHERE Teacher.id = Student.teacher_id
);

-- 2. Obtén una lista de todos los empleados que están asociados con algún estudiante, utilizando EXISTS.
SELECT Employee.name
FROM Employee
WHERE EXISTS (
    SELECT 1
    FROM Student
    WHERE Student.employee_id = Employee.id
);

-- 3. Muestra todos los estudiantes que están asociados con al menos una empresa, utilizando EXISTS.
SELECT Student.name
FROM Student
WHERE EXISTS (
    SELECT 1
    FROM Employee
    WHERE Employee.id = Student.employee_id AND Employee.company_id IS NOT NULL
);
--ANY
-- 1. Muestra todos los empleados que trabajan para una empresa que tiene más de 2 empleados, utilizando ANY.
SELECT Employee.name
FROM Employee
WHERE Employee.company_id = ANY (
    SELECT Company.id
    FROM Company
    JOIN Employee ON Company.id = Employee.company_id
    GROUP BY Company.id
    HAVING COUNT(Employee.id) > 2
);

-- 2. Obtén una lista de los estudiantes cuyo profesor tiene un id mayor que 2, utilizando ANY.
SELECT Student.name
FROM Student
WHERE Student.teacher_id = ANY (
    SELECT Teacher.id
    FROM Teacher
    WHERE Teacher.id > 2
);

-- 3. Consulta todos los estudiantes que están asociados con una empresa cuyo id es mayor que 3, utilizando ANY en la condición.
SELECT Student.name
FROM Student
WHERE Student.employee_id = ANY (
    SELECT Employee.id
    FROM Employee
    WHERE Employee.company_id > 3
);
--CASE
-- 1. Muestra el nombre de todos los empleados junto con una clasificación de "Activo" si su teléfono está registrado, o "Inactivo" si no tienen teléfono.
SELECT Employee.name, 
    CASE 
        WHEN Employee.phone IS NOT NULL THEN 'Activo'
        ELSE 'Inactivo'
    END AS Estado
FROM Employee;

-- 2. Realiza una consulta para mostrar el nombre de todos los estudiantes y su empresa asignada, con un mensaje que indique "Sin empresa" si no tienen una empresa asociada.
SELECT Student.name, 
    CASE 
        WHEN Company.name IS NOT NULL THEN Company.name
        ELSE 'Sin empresa'
    END AS Empresa
FROM Student
LEFT JOIN Employee ON Student.employee_id = Employee.id
LEFT JOIN Company ON Employee.company_id = Company.id;

-- 3. Muestra los nombres de todos los profesores junto con una etiqueta "Tienen estudiantes" si tienen al menos un estudiante asignado.
SELECT Teacher.name, 
    CASE 
        WHEN EXISTS (SELECT 1 FROM Student WHERE Student.teacher_id = Teacher.id) THEN 'Tienen estudiantes'
        ELSE 'No tienen estudiantes'
    END AS Estado
FROM Teacher;
--COALESCE
-- 1. Muestra el nombre y correo de los estudiantes, y en caso de que no tengan teléfono, utiliza COALESCE para mostrar el mensaje "Teléfono no disponible".
SELECT Student.name, Student.email, COALESCE(Student.phone, 'Teléfono no disponible') AS Telefono
FROM Student;

-- 2. Realiza una consulta para obtener el nombre de los empleados y, si no tienen empresa asignada, utilizar COALESCE para mostrar el mensaje "Empresa no asignada".
SELECT Employee.name, COALESCE(Company.name, 'Empresa no asignada') AS Empresa
FROM Employee
LEFT JOIN Company ON Employee.company_id = Company.id;

-- 3. Consulta todos los estudiantes y, si no tienen asignado un teléfono, muestra el mensaje "No disponible" utilizando COALESCE.
SELECT Student.name, COALESCE(Student.phone, 'No disponible') AS Telefono
FROM Student;

# KC--SQL-Avanzado-ETL-DataWarehouse
Repositorio para subir las practicas correspondientes al modulo SQL Avanzado, ETL y DataWarehouse.

Para completar las practicas de este modulo, se nos requiere completar una serie de actividades numeradas del 1 al 13, en las que hay dos partes principales.
La primera, que comprende los ejercicios 1 y 2, nos requiere crear una base de datos ficticia para KeepCoding, donde se podrian almacenar datos sobre los distintos bootcamps que se ofrecen, sobre los alumnos, o sobre las practicas, por ejemplo. En la segunda parte, que comprende desde el ejercicio 3 al 13, trabajamos sobre unos ficheros sql, con los que tenemos que realizar una serie de cambios y actualizaciones en base a los enunciados de cada ejercicio.

Para estos ejercicios, hemos usado distintos softwares en base a las caracteristicas de cada ejercicio. Entre ellos estan Drawio, TablePlus, y BigQuery.

## Primera Parte: 1 & 2

El enunciado del ejercicio 1 nos requiere realizar un diagrama de entidad relacion con el que poder modelar una base de datos para Keepcoding. Para ello, hemos utilizado Drawio y dibujado las siguientes entidades, con sus correspondientes detalles, que puede verse en el archivo Practica KC - SQL&DW - 1.drawio:

students (student_ID, name, email, phone, address)
bootcamps (bootcamp_ID, name, duration, cost)
courses (course_ID, title, description, hours, level)
instructors (instructor_ID, name, specialization)
assignments (assignment_ID, course_ID, title, description, max_score)
enrollments (enrollment_ID, student_ID, bootcamp_ID, enrollment_date, completion_status, completion_date, progress_percentage)
payments (payment_ID, student_ID, amount, payment_date)
bootcamp_courses (bootcamp_course_ID, bootcamp_ID, course_ID)
instructor_courses (instructor_course_ID, instructor_ID, course_ID)
student_assignments (student_ID, assignment_ID, submission_date, score, status)

Hemos decidido crear estas entidades basandonos en las actividades que KeepCoding realiza, con la idea de almacenar los datos que pueden ser de utilidad. Por ello tenemos informacion sobre los estudiantes, sobre los diferentes bootcamps que KeepCoding ofrece (incluyendo su duracion y coste), los cursos que componen estos bootcamps, las tareas o practicas que se han de realizar (informacion importante para los administradores y profesores), los instructores que dan clases en los cursos, las inscripcciones (y el momento de la inscripcion en el que el estudiante en concreto se encuentra), los pagos, asi como tres entidades union entre bootcamps y cursos, instructores y cursos, y estudiantes y practicas. Estas tres ultimas tablas de union nos parecen de utilidad por que los cursos pueden encontrarse en bootcamps distintos, y los instructores pueden tambien enseñar en cursos distintos. La ultima tabla union nos puede ser util tambien para obtener informacion sobre la dificultad de las tareas, por ejemplo.

En cuanto a las relaciones entre estas entidades y tablas de union, tenemos las siguientes:

1-to-many
students - enrollments - Un estudiante se puede inscribir en varios bootcamps
bootcamps - enrollments - Los bootcamps pueden tener muchas inscripciones
students - payments - Un estudiante puede realizar multiples pagos
courses - assignments - Los cursos pueden tener varias practicas
instructors - instructor_courses - Los profesores pueden enseñar en varios cursos
courses - instructor_courses - Los cursos, a su vez, pueden tener varios profesores
students - student_assignments - Los estudiantes pueden entregar varias practicas
assignments - student_assignments - Y a su vez, las practicas son entregadas por varios estudiantes

Many-to-Many
bootcamp_courses - union entre bootcamps y cursos
instructor_courses - union entre profesores y cursos
student_assignments - union entre estudiantes y practicas

En el ejercicio 2 teniamos que crear estas tablas que habiamos dibujado a traves de una query en SQL. Para ello hemos creado una query que puede encontrarse en el archivo Practica KC - SQL&DW - 2.sql. Esta query se ha realizado en TablePlus, por que el enunciado mencionaba de manera explicita que el script debia poder ejecutarse en PostgreSQL. Ademas, el ejercicio hacia hincapie en las restricciones necesarias para crear el diagrama, y PostgreSQL ofrece una manera clara y legible de reflejarlas.

## Segunda Parte: 3 - 13

Para los siguientes ejercicios hemos utilizado el software BigQuery de Google, por que dados los multiples cambios que debiamos realizar, y las limitaciones que la version gratuita de TablePlus nos imponian, nos parecia mucho mas comodo trabajar en BigQuery. En estos ejercicios hemos trabajado con los tres ficheros proporcionados, y trabajado con ellos para conseguir los cambios que se nos requerian. Cada ejercicio nos requiere producir una query y exportarla en archivo sql. Asi, hemos creado una query por cada ejercicio, numeradas del 3 al 13, y que corresponden cada una a su ejercicio del mismo numero.


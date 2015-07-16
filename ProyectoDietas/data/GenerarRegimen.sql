DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `GenerarRegimen`(idMP INT)
BEGIN
    -- VALORES QUE SON REFERENCIA PARA ESTABLECER EL APORTE CALÓRICO REQUERIDO POR EL PACIENTE
    -- VALORES OBTENIDOS DEL ÚLTIMO REGISTRO DE SU PROGRESO.
    -- VALORES OBTENIDOS DE LA INFORMACIÓN DEL PACIENTE.
    DECLARE geb,eta,gastototal,altura,peso,gastoActividad FLOAT;
    DECLARE edad,idIntensidad INT;
    DECLARE genero VARCHAR(45);
    DECLARE fechaReg DATETIME;
    DECLARE idDietaGen INT;
    -- CALL GenerarRegimen(2)
    SELECT u.sexo, TIMESTAMPDIFF(Year,u.fechaNacimiento,NOW()) 
        INTO @genero,@edad
        from Usuario u inner join MedicoPaciente m on u.idUsuario = m.Paciente_idUsuarioPaciente
        where m.idMedicoPaciente = idMP;
    -- SELECT @genero,@edad;
    SELECT p.altura,p.peso, i.idIntensidad 
        INTO @altura,@peso,@idIntensidad
        FROM Progreso p inner join Actividad a on p.idActividad = a.idActividad
     inner join ActividadIntensidad i on a.idIntensidad = i.idIntensidad
     inner join MedicoPaciente mp on mp.Paciente_idUsuarioPaciente = p.idUsuarioPaciente
    where mp.idMedicoPaciente = idMP ORDER BY p.fechaRegistro DESC LIMIT 1;
    -- SELECT @altura,@peso,@idIntensidad;
    -- SELECT 'GENERANDO GEB Y ETA';
    SET @geb = ObtenerGastoEnergicoBasal(@peso,@altura,@edad,@genero);
    -- SELECT @geb;
    SET @eta = @geb * 0.08;
    -- SELECT @eta;
    -- SELECT @idIntensidad;
    CASE @idIntensidad
        When 1 THEN
            SET @gastoActividad = 1.25;
        WHEN 2 THEN
            SET @gastoActividad = 1.5; 
        WHEN 3 THEN
            SET @gastoActividad = 1.9;
        ELSE 
             SET @gastoActividad = 0;
    END CASE;
    -- SELECT @gastoActividad;
    
    SET @gastototal = @geb*@gastoActividad +@eta ;
    -- SELECT 'Gasto Total para el paciente' + @gastototal;
    SET @fechaReg = CURRENT_DATE();
    -- REGISTRA EL REGIMEN ACTUAL
    INSERT INTO Dieta (idMedicoPaciente,fechaInicio,caloriasDieta) values (idMP,@fechaReg,@gastototal);
    /* REGISTRA LA PORCIÓN EN GRAMOS DEL APORTE EN PROTEINAS, CARBOHIDRATOS Y LÍPIDOS DEACUERDO 
    A LAS PROPORCIONES INDICADAS POR LA NUTRIÓLOGA CONSULTADA Y LA REFERENCIA BIBLIOGRÁFICA */
    
    SELECT idDieta 
        INTO @idDietaGen
        from Dieta where idMedicoPaciente = idMP AND fechaInicio = @fechaReg ORDER BY idDieta DESC LIMIT 1 ;
    
    select last_insert_id();
    
    INSERT INTO NutrientesDieta
    VALUES (1,@idDietaGen,.15*@gastototal/4);
    INSERT INTO NutrientesDieta values (2,@idDietaGen,@gastototal*.60/4);
    INSERT INTO NutrientesDieta values (3,@idDietaGen,.20*@gastototal/9);
    INSERT INTO NutrientesDieta values (5,@idDietaGen,@gastototal*.02);
    
	
END$$
DELIMITER ;
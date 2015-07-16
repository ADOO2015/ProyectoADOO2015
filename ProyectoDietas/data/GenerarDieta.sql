DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `GenerarDieta`(idMP INT)
BEGIN
	DECLARE totalCalorias,totalFibra,totalColesterol,totalCarbohidratos,totalProteina,totalLipidos FLOAT;
	DECLARE idRegimen INT;
    DECLARE CidPlatoF,CidPlatoE,CidPostre,CidBebida INT;
    DECLARE DidBebida,DidFruta,DidPlatoM INT;
    DECLARE AidPlatoL,AidBebida INT;
    DECLARE RidRefrigerioM,RidRefrigerioV INT;
    DECLARE sumCalorias,sumCaloriasDes,sumCaloriasCena,sumCaloriasRM,sumCaloriasRV FLOAT;
    
    SELECT idDieta,caloriasDieta
		into @idRegimen,@totalCalorias
        from Dieta where idMedicoPaciente = idMP order by idDieta desc limit 1 ;
	
   SELECT @idRegimen,@totalCalorias;
   
	CREATE TEMPORARY TABLE PlatoLigero (
		idPlato INT PRIMARY KEY NOT NULL,
        nombre VARCHAR(500),
        calorias FLOAT,
        porcion FLOAT
    );
    
    CREATE TEMPORARY TABLE PlatoMedio (
		idPlato INT PRIMARY KEY NOT NULL,
        nombre VARCHAR(200),
        calorias FLOAT,
        porcion FLOAT
    );
    
    CREATE TEMPORARY TABLE PlatoFuertePersonalizado(
		idPlato INT PRIMARY KEY NOT NULL,
        nombre VARCHAR(200),
        calorias FLOAT,
        porcion FLOAT
    );
    
    CREATE TEMPORARY TABLE PlatoEntradaPersonalizado(
		idPlato INT PRIMARY KEY NOT NULL,
        nombre VARCHAR(200),
        calorias FLOAT,
        porcion FLOAT
    );
    
    CREATE TEMPORARY TABLE BebidasPersonalizado(
		idPlato INT PRIMARY KEY NOT NULL,
        nombre VARCHAR(200),
        calorias FLOAT,
        porcion FLOAT
    
	);
    CREATE TEMPORARY TABLE PostrePersonalizado(
		idPlato INT PRIMARY KEY NOT NULL,
        nombre VARCHAR(200),
        calorias FLOAT,
        porcion FLOAT
    );


	CREATE TEMPORARY TABLE ComidaPersonalizada (
		idComida INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
        idBebida INT,
        idPlatoEntrada INT,
        idPlatoFuerte INT,
        idPostre INT,
        calorias FLOAT
    );
    
    
    CREATE TEMPORARY TABLE DesayunoPersonalizado (
		idDesayuno INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
        idBebida INT,
        idPlatoMediano INT,
		idFruta INT,
        sumaCalorias FLOAT
    );
    
    CREATE TEMPORARY TABLE CenaPersonalizada(
		idCena INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
        idBebida INT,
        idPlatoLigero INT,
        sumaCalorias FLOAT
    );
    
   CREATE TEMPORARY TABLE AlimentoDieta (
		idAlimento int,Tiempo_idTiempo int
	);
    
   
-- PLATO FUERTE Y ENTRADA PARA LA COMIDA
	
	INSERT INTO PlatoFuertePersonalizado SELECT * from PlatoFuerte where caloriasPlatoFuerte BETWEEN @totalCalorias*.15 AND @totalCalorias*.20 ORDER BY RAND();
   -- SELECT * from PlatoFuertePersonalizado;
    
    INSERT INTO PlatoEntradaPersonalizado SELECT * from PlatoEntrada where caloriasPlatoEntrada BETWEEN @totalCalorias*.10 AND @totalCalorias*.15 ORDER BY RAND();
	-- SELECT * from PlatoEntradaPersonalizado;
    
-- BEBIDAS PARA DESAYUNO,COMIDA Y CENA; POSTRE PARA COMIDA
    
    INSERT INTO BebidasPersonalizado SELECT * from Bebida where caloriasBebida <= @totalCalorias*.07 order by RAND() LIMIT 50;
    INSERT INTO PostrePersonalizado SELECT * from Postre where caloriasPostre <= @totalCalorias*.07 order by rand() LIMIT 50;
    
    -- SELECT (pe.calorias + pf.calorias +b.calorias + p.calorias)*100/@totalCalorias from PlatoFuertePersonalizado pf,PlatoEntradaPersonalizado pe,BebidasPersonalizado b,PostrePersonalizado p LIMIT 500;
    
-- COMIDA

    INSERT INTO ComidaPersonalizada (idPlatoEntrada,idPlatoFuerte,idBebida,idPostre,calorias)
    SELECT pe.idPlato,pf.idPlato, b.idPlato,p.idPlato,(pe.calorias + pf.calorias +b.calorias + p.calorias)
    from PlatoFuertePersonalizado pf,PlatoEntradaPersonalizado pe,BebidasPersonalizado b,PostrePersonalizado p LIMIT 5000;
    
    SELECT idPlatoEntrada,idPlatoFuerte,idBebida,idPostre,calorias
		INTO	@CidPlatoE,@CidPlatoF,@CidBebida,@CidPostre,@sumCalorias
		from ComidaPersonalizada order by rand() limit 1;
	
    INSERT INTO AlimentoDieta VALUES (@CidPlatoE,2),(@CidPlatoF,2),(@CidBebida,2),(@CidPostre,2);
    -- SELECT * from AlimentoDieta;
    
-- FIN DE LA COMIDA        

    -- REGISTRA LOS PLATOS MEDIOS (PARA EL DESAYUNO) Y LOS PLATOS LIGEROS (Para la cena)
    
    INSERT INTO PlatoLigero  SELECT * FROM PlatoEntrada where caloriasPlatoEntrada between @totalCalorias*.08 AND @totalCalorias*.12 order by rand() ;
	INSERT INTO PlatoLigero	SELECT * FROM PlatoFuerte where caloriasPlatoFuerte between @totalCalorias*.08 AND @totalCalorias*.12 order by rand() ;
    -- SELECT * from PlatoLigero;
    
    
	INSERT INTO PlatoMedio	SELECT * FROM PlatoFuerte where caloriasPlatoFuerte between @totalCalorias*.12 AND @totalCalorias*.15;
    -- SELECT * from PlatoMedio;
    
	INSERT INTO DesayunoPersonalizado (idBebida,idPlatoMediano,idFruta,sumaCalorias)
    SELECt b.idPlato,pm.idPlato,f.idAlimento,(pm.calorias + b.calorias + f.calorias)
		from PlatoMedio pm,BebidasPersonalizado b,Fruta f ;
    
    SELECT idBebida,idPlatoMediano,idFruta,sumaCalorias
    INTO @DidBebida,@DidPlatoM,@DidFruta,@sumCaloriasDes
	from DesayunoPersonalizado
    where sumaCalorias
    BETWEEN @totalCalorias*.19 AND @totalCalorias*.28 order by rand() LIMIT 1;
    
    SET @sumCalorias = @sumCalorias + @sumCaloriasDes;
    INSERT INTO AlimentoDieta VALUES (@DidBebida,1),(@DidPlatoM,1),(@DidFruta,1);
    
    -- SELECT @totalCalorias,@sumCalorias;
-- FIN DEL DESAYUNO
	DELETE FROM BebidasPersonalizado where idPlato<=15000;
    INSERT INTO BebidasPersonalizado SELECT * from Bebida where caloriasBebida <= @totalCalorias*.05 order by RAND() LIMIT 75;
     INSERT INTO CenaPersonalizada(idBebida,idPlatoLigero,sumaCalorias) 
		SELECT b.idPlato,pl.idPlato,(pl.calorias + b.calorias) FROM BebidasPersonalizado b,PlatoLigero pl LIMIT 4500;
	 SELECT idBebida,idPlatoLigero,sumaCalorias
		INTO @AidBebida,@AidPlatoL,@sumCaloriasCena
		FROM CenaPersonalizada 
     where sumaCalorias <= (@totalCalorias - @sumCalorias)/2 order by rand() limit 1 ;
	
    INSERT INTO AlimentoDieta VALUES (@AidBebida,4),(@AidPlatoL,4);
    
	

	SET @sumCalorias = @sumCalorias + @sumCaloriasCena;
    -- SELECT @totalCalorias,@sumCalorias;
    
    
    SELECT idRefrigerio,caloriasRefrigerio
		INTO @RidRefrigerioM,@sumCaloriasRM
        from Refrigerio where caloriasRefrigerio 
		BETWEEN (@totalCalorias-@sumCalorias)*.4 AND (@totalCalorias-@sumCalorias)*.6
    ORDER BY RAND() LIMIT 1 ;
    
    SELECT idRefrigerio,caloriasRefrigerio
		INTO @RidRefrigerioV,@sumCaloriasRV
        from Refrigerio where caloriasRefrigerio 
		BETWEEN (@totalCalorias-@sumCalorias)*.4 AND (@totalCalorias-@sumCalorias)*.6
    ORDER BY RAND() LIMIT 1 ;
	
    SET @sumCalorias = @sumCalorias + @sumCaloriasRM + @sumCaloriasRV;
	SELECT @totalCalorias,@sumCalorias;
    INSERT INTO AlimentoDieta VALUES (@RidRefrigerioM,3),(@RidRefrigerioV,5);
	
    SELECT a.idAlimento,a.nombre,t.idTiempo,t.descripcion 
		from AlimentoDieta ad inner join Alimento a on ad.idAlimento = a.idAlimento
    inner join Tiempo t on t.idTiempo = ad.Tiempo_idTiempo;

	INSERT INTO AlimentosDieta (idAlimento,idDieta,Tiempo_idTiempo)
		SELECT ad.idAlimento,@idRegimen,ad.Tiempo_idTiempo from AlimentoDieta ad;
    
    
    drop table AlimentoDieta;
    drop table PlatoMedio;
    drop table PlatoLigero;
    drop table PlatoFuertePersonalizado;
	drop table PlatoEntradaPersonalizado;
    drop table BebidasPersonalizado;
    drop table ComidaPersonalizada;
    drop table PostrePersonalizado;
    drop table DesayunoPersonalizado;
    drop table CenaPersonalizada;
END$$
DELIMITER ;

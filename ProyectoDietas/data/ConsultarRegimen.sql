DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ConsultarRegimen`(idMP int,idD int)
BEGIN
	SELECT 'Calorias',d.caloriasDieta FROM Dieta d where d.idDieta = idD
	UNION
    select n.nombre,nd.cantidad from Dieta d inner join NutrientesDieta nd on d.idDieta = nd.idDieta
		inner join Nutrientes n on n.idNutrientes = nd.idNutriente
	where idMedicoPaciente = idMP and d.idDieta = idD;
    
    
END$$
DELIMITER ;

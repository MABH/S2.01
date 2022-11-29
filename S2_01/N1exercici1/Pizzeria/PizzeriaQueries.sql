USE pizzeria;
Select clients.localitat, productes.tipus From productes 
INNER JOIN quantitats ON productes.id_producte = quantitats.producte_id 
INNER JOIN comandes ON comandes.id_comanda = quantitats.comanda_id 
INNER JOIN clients ON clients.id_client = comandes.client_id WHERE productes.tipus = 'BEGUDA';
Select comandes.id_comanda, empleats.nom FROM empleats
INNER JOIN comandes ON empleats.id_empleat = comandes.empleat_id;
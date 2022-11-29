SELECT * FROM culdampolla.factura;
SELECT * FROM culdampolla.factura INNER JOIN culdampolla.client ON factura.usuari_id = client.id_client WHERE data_registre >= "2021-10-11";
SELECT ulleres.marca, empleat.nom FROM culdampolla.ulleres 
INNER JOIN culdampolla.factura ON ulleres.id_ulleres = factura.ulleres_id 
INNER JOIN culdampolla.empleat ON factura.empleat_id = empleat.id_empleat
INNER JOIN culdampolla.client ON factura.usuari_id = client.id_client 
WHERE data_registre = "2022-10-12";
SELECT proveidor.* FROM culdampolla.proveidor 
INNER JOIN culdampolla.ulleres ON ulleres.proveidor_id = proveidor.idproveidor
INNER JOIN culdampolla.factura ON factura.ulleres_id = ulleres.id_ulleres;
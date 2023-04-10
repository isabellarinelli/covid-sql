-- PROJETO BANCO DE DADOS
-- Isabella Nunes Rinelli, Letícia de Assis Godoi, Lívia dos Reis Edinger da Silva e Mariana Koerber Albino

CREATE SCHEMA ControleCovid;
USE ControleCovid;

-- IMPLEMENTAÇÃO

create table cidadao(
 cpf numeric(11) not null primary key,
 nome varchar(100),
 sexo char(1) not null,
datanascimento date not null,
idade integer,
contato varchar(14));

create table Comorbidade(
cpfCidadao numeric(11) not null,
idComorbidade INT NOT NULL AUTO_INCREMENT,
detalhamento varchar(100),
PRIMARY KEY(IdComorbidade),
foreign key (cpfCidadao) references cidadao(cpf));

CREATE TABLE TipoContato (
	IdTipoContato INT NOT NULL,
    Tipo varchar(100),
	PRIMARY KEY(IdTipoContato)
);

CREATE TABLE Contato (
	IdContato INT NOT NULL,
    Descricao varchar(100),
    tipoContato INT NOT NULL, 
    crmMedico VARCHAR(9) not null,
    FOREIGN KEY (tipoContato) REFERENCES TipoContato(IdTipoContato),
    PRIMARY KEY(IdContato)
);

CREATE TABLE Medicos(
  crm VARCHAR(9) NOT NULL,
  nome VARCHAR(50) NOT NULL,
  contato INT NOT NULL,
  especialidade VARCHAR(100) NOT NULL,
  FOREIGN KEY (contato) REFERENCES contato(IdContato),
  PRIMARY KEY(crm)
);

CREATE TABLE Sintomas(
  IdSintoma INT NOT NULL AUTO_INCREMENT,
  descricao VARCHAR(100) NOT NULL,
  tempoInicio int NOT NULL,
  cpfCidadao NUMERIC(11) NOT NULL,
  crmMedico VARCHAR(9) NOT NULL,
  PRIMARY KEY(IdSintoma),
  FOREIGN KEY (cpfCidadao) REFERENCES Cidadao(cpf),
  FOREIGN KEY (crmMedico) REFERENCES Medicos(crm)
);

CREATE TABLE Exame(
  IdExame INT NOT NULL,
  tipo VARCHAR(50) NOT NULL,
  cpfCidadao NUMERIC(11) NOT NULL,
  crmMedicoSolicitante VARCHAR(9) NOT NULL,
  PRIMARY KEY(IdExame),
  FOREIGN KEY (cpfCidadao) REFERENCES Cidadao(cpf),
  FOREIGN KEY (crmMedicoSolicitante) REFERENCES Medicos(crm)
);

CREATE TABLE Resultado(
  IdResultado INT NOT NULL AUTO_INCREMENT,
  laudo CHAR(8) NOT NULL, 
  IdExame INT NOT NULL,
  PRIMARY KEY(IdResultado)
);

CREATE TABLE Positivo(
  IdPositivo INT NOT NULL AUTO_INCREMENT,
  dataRecebimento DATE NOT NULL,
  IdResultado INT NOT NULL,
  PRIMARY KEY(IdPositivo),
  FOREIGN KEY(IdResultado) REFERENCES Resultado(IdResultado)
);

-- INSERÇÃO DE DADOS

-- populando a tabela CIDADAO
insert into cidadao values
('39594474009', 'Lucca Luan da Silva','M','2000-12-03', '22', '(55) 989953679'),
('97820182288', 'Cláudia Monteiro', 'F', '1989-08-18', '32', '(51) 412666149'),
('59195589031', 'Caio Mozer Quintanilha', 'M','1957-09-16', '64', '(55) 996182122'),
('91111208000', 'Valentina Stella Assunção','F', '2002-03-11', '20', '(51) 989953679'),
('41818108100', 'Thiago Barbosa Pinho', 'M', '1981-02-25', '41', '(54) 286892949'),
('31937258548', 'Marcelle Trancoso Velasco', 'F', '1997-10-01', '24','(54) 814790062'),
('38717830052', 'Gabriel Santana Mozer', 'M', '1999-08-18', '22', '(53) 560208168'),
('30579083063', 'Lucia Peixoto Valente', 'F', '1976-03-03', '46','(53) 385417529'),
('90907925030', 'Manoel Paulo Dutra', 'M', '1966-01-31', '56', '(54) 448879777'),
('14002565009', 'Patrícia Duarte Torres', 'F', '1977-04-12', '45', '(51) 481004760'),
('60840441070', 'Fernando Valente Rios', 'M', '1998-06-09', '24', '(54) 200865791'),
('56023368000', 'Ana Julia Pontes Carvalho', 'F', '1995-12-04', '26', '(55) 445876208'),
('60202577031', 'Jean Correia Neto', 'M', '1987-05-27', '35', '(51) 670322167'),
('25167907080', 'Cristiana Veiga da Conceição', 'F', '1959-03-20', '63', '(53) 113677314'),
('40422293016', 'Rafael Monnerat Dias', 'M', '1993-07-04', '29', '(55) 220217313'),
('31038005094', 'Stefany Melo Magalhães', 'F', '1983-01-21', '39', '(51) 221169074'),
('86234705081', 'Flavio Goulart Braz', 'M', '1966-09-12', '55', '(54) 745571570'),
('68689964037', 'Maria Nazaré Vieira Vaz', 'F', '1947-02-07', '74', '(53) 631012280'),
('20162268114', 'Ivan Castilho Spilman', 'M', '1990-11-29', '31', '(51) 685376001'),
('63644069042', 'Ana Maria Muniz Linhares', 'F', '1964-05-27', '58', '(55) 796464403'),
('75416804009', 'Fabiana Linhares', 'F', '2008-02-05', '14', '(54) 781390618'),
('38008662000', 'Adriano Felix Correia', 'M', '1971-01-03', '51', '(55) 818294414'),
('45693958051', 'Andrea Vidal Soares', 'F', '1986-05-17', '36', '(53) 233321380'),
('03701384061', 'Enzo Cordeiro Carmoriz', 'M', '2011-07-09', '11', '(51) 730181990');

-- populando a tabela COMORBIDADE
insert into comorbidade (cpfCidadao,detalhamento) values
('39594474009', 'Insuficiência cardíaca'),
('59195589031', 'Hipertensão'),
('31937258548', 'Diabetes'),
('38717830052', 'Asma'),
('30579083063', 'Diabetes'),
('90907925030', 'Hipertensão'),
('60202577031', 'Diabetes'),
('60840441070', 'Asma'),
('63644069042', 'Diabetes'),
('38008662000', 'Insuficiência cardíaca'),
('40422293016', 'Hipertensão'),
('25167907080', 'Hipertenção'),
('20162268114', 'Insuficiência cardíaca');

-- populando a tabela com os tipos de contato
insert into tipocontato values (1, 'Celular'), (2, 'Telefone'), (3, 'E-mail');

-- populando a tabela com os contatos dos médicos
insert into contato values (001, '(73) 927389211', 1, '123456/RS'), (002, '(54) 987012211',  1, '127776/RS'),
(003, '(51) 30356281', 2, '567891/RS'), (004, '(51) 30315663', 2, '867891/RS'), 
(005, 'marina.souza@clinicars.com', 3, '987891/RS');

-- populando a tabela MEDICOS
insert into medicos values
('123456/RS', 'Luis Claudio Rocha', 1, 'Cardiologista'),
('567891/RS', 'Ana Paula Silva', 2, 'Clínico geral'),
('987891/RS', 'Marina Antônia Souza', 3, 'Clínico geral'),
('127776/RS', 'Isabel Cristina Pereira dos Santos', 4, 'Cardiologista'),
('867891/RS', 'Maria da Silveira', 5, 'Clínico geral');

-- definindo os crm como chave estrangeira de contato

ALTER TABLE Contato ADD FOREIGN KEY (crmMedico) REFERENCES Medicos(crm);

-- populando a tabela EXAME
insert into exame values
('9623', 'TR', '39594474009','123456/RS'),  
('3307','TR','97820182288', '567891/RS'), 
('9373', 'RT-qPCR', '59195589031', '867891/RS'),
('4527', 'RT-qPCR', '41818108100', '567891/RS'),
('4801', 'TR', '91111208000', '867891/RS'),
('1342','TR','31937258548', '867891/RS'),
('5233','RT-qPCR','38717830052', '123456/RS'),
('8037', 'RT-qPCR', '30579083063', '567891/RS'),
('5149', 'TR', '90907925030', '567891/RS'),
('7177', 'TR', '14002565009','127776/RS'),
('1050', 'RT-qPCR', '60840441070', '567891/RS'),
('8574', 'RT-qPCR', '56023368000', '123456/RS'),
('3765', 'TR', '60202577031', '987891/RS'),
('5967', 'TR', '25167907080', '123456/RS'),
('9346', 'RT-qPCR', '40422293016', '987891/RS'),
('8407', 'RT-qPCR', '31038005094', '987891/RS'),
('2082', 'TR', '86234705081', '987891/RS'),
('2798', 'TR', '68689964037', '127776/RS'),
('1313', 'RT-qPCR', '20162268114', '127776/RS'),
('7251', 'RT-qPCR', '63644069042', '867891/RS');

-- populando a tabela RESULTADOS
insert into resultado (laudo, idExame) values
('positivo','9623'),
('positivo','3307'),
('positivo','9373'),
('positivo','4527'),
('negativo', '4801'),
('negativo', '1342'),
('negativo', '5233'),
('negativo', '8037'),
('positivo','5149'),
('positivo','7177'),
('positivo','1050'),
('positivo','8574'),
('negativo', '3765'),
('negativo', '5967'),
('negativo', '9346'),
('negativo', '8407'),
('positivo','2082'),
('positivo','2798'),
('positivo','1313'),
('positivo','7251');

insert into sintomas (descricao, tempoinicio, cpfCidadao, crmMedico)values
('Perda de paladar e olfato', '2', '39594474009', '123456/RS'),
('Tosse', '4', '97820182288', '567891/RS'),
('Dor de garganta', '3', '97820182288', '567891/RS'),
('Dor de garganta', '3', '59195589031', '987891/RS'),
('Tosse', '2', '59195589031', '987891/RS'),
('Cansaço', '2', '59195589031', '987891/RS'),
('Cansaço', '5', '91111208000', '127776/RS'),
('Tosse', '2', '91111208000', '127776/RS'),
('Febre', '1', '91111208000', '127776/RS'),
('Febre', '2', '41818108100', '867891/RS'),
('Tosse', '5', '31937258548', '123456/RS'),
('Cansaço', '7', '38717830052','123456/RS'),
('Dor de cabeça', '2', '38717830052','123456/RS'),
('Dor de cabeça', '1', '30579083063', '567891/RS'),
('Perda de paladar e olfato', '2','90907925030','567891/RS'),
('Dor de garganta', '2','90907925030','567891/RS'),
('Diarreia', '2','90907925030','567891/RS'),
('Tosse', '2','90907925030','567891/RS'),
('Perda de paladar e olfato','3','14002565009', '127776/RS'),
('Dor de garganta','3','14002565009', '127776/RS'),
('Diarreia','1','14002565009', '127776/RS'),
('Dor de cabeça','3', '60840441070', '123456/RS'),
('Perda de paladar e olfato','3', '60840441070', '123456/RS'),
('Tosse', '2', '56023368000', '867891/RS'),
('Cansaço', '2', '56023368000', '867891/RS'),
('Tosse', '5', '60202577031', '867891/RS'),
('Dor de cabeça', '5', '60202577031', '867891/RS'),
('Perda de paladar e olfato', '3', '25167907080', '127776/RS'),
('Perda de paladar e olfato', '3', '40422293016', '127776/RS'),
('Tosse', '3', '40422293016', '127776/RS'),
('Perda de paladar e olfato', '1', '31038005094', '987891/RS'),
('Dor de cabeça', '1', '31038005094', '987891/RS'),
('Tosse', '1', '86234705081', '987891/RS'),
('Tosse', '4', '68689964037', '567891/RS'),
('Dor de cabeça', '4', '68689964037', '567891/RS'),
('Tosse', '2', '20162268114', '567891/RS'),
('Perda de paladar e olfato', '2', '20162268114', '567891/RS'),
('Dor de cabeça', '3', '63644069042', '867891/RS'),
('Cansaço', '3', '63644069042', '867891/RS');

insert into positivo (dataRecebimento, idResultado) values
('2021-01-02','1');
insert into positivo (dataRecebimento, idResultado) values
('2021-01-19','2'),
('2021-02-03','3'),
('2021-02-16','4'),
('2021-03-24','9'),
('2021-04-30','10'),
('2021-05-09','11'),
('2021-06-22','12'),
('2021-07-27','17'),
('2021-08-23','18'),
('2021-09-11','19'),
('2021-10-12','20');

-- CONSULTAS
-- consulta 1: que recupera o número de de cidadãos atendidos
 -- que relataram pelo menos dois sintomas
SELECT COUNT(*) AS Cidadaos2ouMaisSintomas
FROM Cidadao C
WHERE C.cpf IN 
	(SELECT C.cpf
	FROM Sintomas S
		INNER JOIN Cidadao C ON S.cpfcidadao = C.cpf
	GROUP BY C.cpf
	HAVING COUNT(S.cpfcidadao) >= 2);

-- consulta 2: retorna a quantidade de pacientes testados positivos, agrupados por
-- nome do tipo de teste realizado
SELECT E.Tipo, COUNT(E.cpfCidadao) AS QuantidadePositivos
FROM Exame E
	INNER JOIN Resultado R ON E.idexame = R.idexame
WHERE R.laudo LIKE 'positivo'
GROUP BY E.tipo;

-- consulta 3: listagem de notificação, que informa o nome do paciente, a idade,
-- o tipo de teste e a data de testagem de todos os pacientes testados positivos
SELECT C.Nome, C.Idade, E.Tipo AS TipoExame, P.DataRecebimento
FROM Exame E
	INNER JOIN Resultado R ON E.idexame = R.idexame
	INNER JOIN Cidadao C ON E.cpfcidadao = C.cpf
	INNER JOIN Positivo P ON R.idresultado = P.idresultado
WHERE R.laudo LIKE 'positivo';

-- consulta 4: retorna a quantidade de pacientes testados negativos
SELECT COUNT(E.cpfcidadao) AS QuantidadeNegativos
FROM Exame E
	INNER JOIN Resultado R ON E.idexame = R.idexame
WHERE R.laudo LIKE 'negativo';

-- consulta 5: retorna o paciente mais novo que testou positivo
SELECT C.nome AS PacienteMaisNovo
FROM Cidadao C
WHERE C.datanascimento =
	(SELECT MAX(C.datanascimento)
	FROM Cidadao C
		INNER JOIN Exame E ON C.cpf = E.cpfcidadao
		INNER JOIN Resultado R ON E.idexame = R.idexame
	WHERE laudo LIKE 'positivo');
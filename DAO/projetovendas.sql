/*
 Navicat Premium Data Transfer

 Source Server         : localhost_33090
 Source Server Type    : MySQL
 Source Server Version : 80027
 Source Host           : localhost:3390
 Source Schema         : projetovendas

 Target Server Type    : MySQL
 Target Server Version : 80027
 File Encoding         : 65001

 Date: 22/05/2022 19:21:57
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for clientes
-- ----------------------------
DROP TABLE IF EXISTS `clientes`;
CREATE TABLE `clientes`  (
  `ID` int NOT NULL AUTO_INCREMENT,
  `NOME_CLIENTE` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `CIDADE` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `UF` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 21 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of clientes
-- ----------------------------
INSERT INTO `clientes` VALUES (1, 'CLIENTE 1', 'SAO PAULO', 'SP');
INSERT INTO `clientes` VALUES (2, 'CLIENTE 2', 'RIO DE JANEIRO', 'RJ');
INSERT INTO `clientes` VALUES (3, 'CLIENTE 3', 'MARINGA', 'PR');
INSERT INTO `clientes` VALUES (4, 'CLIENTE 4', 'SAO PAULO', 'SP');
INSERT INTO `clientes` VALUES (5, 'CLIENTE 5', 'GUARULHOS', 'SP');
INSERT INTO `clientes` VALUES (6, 'CLIENTE 6', 'RIO DE JANEIRO', 'RJ');
INSERT INTO `clientes` VALUES (7, 'CLIENTE 7', 'RIO DE JANEIRO', 'RJ');
INSERT INTO `clientes` VALUES (8, 'CLIENTE 8', 'MARINGA', 'PR');
INSERT INTO `clientes` VALUES (9, 'CLIENTE 9', 'LONDRINA', 'PR');
INSERT INTO `clientes` VALUES (10, 'CLIENTE 10', 'PALMAS', 'TO');
INSERT INTO `clientes` VALUES (11, 'CLIENTE 11', 'PALMAS', 'TO');
INSERT INTO `clientes` VALUES (12, 'CLIENTE 12', 'ARAGUAINA', 'TO');
INSERT INTO `clientes` VALUES (13, 'CLIENTE 13', 'GURUPI', 'TO');
INSERT INTO `clientes` VALUES (14, 'CLIENTE 14', 'CURITIBA', 'PR');
INSERT INTO `clientes` VALUES (15, 'CLIENTE 15', 'CURITIBA', 'PR');
INSERT INTO `clientes` VALUES (16, 'CLIENTE 16', 'LONDRINA', 'PR');
INSERT INTO `clientes` VALUES (17, 'CLIENTE 17', 'SAO PAULO', 'SP');
INSERT INTO `clientes` VALUES (18, 'CLIENTE 18', 'SAO PAULO', 'SP');
INSERT INTO `clientes` VALUES (19, 'CLIENTE 19', 'RIO DE JANEIRO', 'RJ');
INSERT INTO `clientes` VALUES (20, 'CLIENTE 20', 'RIO DE JANEIRO', 'RJ');

-- ----------------------------
-- Table structure for pedido_venda
-- ----------------------------
DROP TABLE IF EXISTS `pedido_venda`;
CREATE TABLE `pedido_venda`  (
  `ID` int NOT NULL AUTO_INCREMENT,
  `CD_CLIENTE` int NOT NULL,
  `VALOR_TOTAL` decimal(16, 6) NOT NULL,
  `DT_EMISSAO` datetime NOT NULL,
  PRIMARY KEY (`ID`) USING BTREE,
  INDEX `fk_cliente`(`CD_CLIENTE` ASC) USING BTREE,
  CONSTRAINT `fk_cliente` FOREIGN KEY (`CD_CLIENTE`) REFERENCES `clientes` (`ID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of pedido_venda
-- ----------------------------
INSERT INTO `pedido_venda` VALUES (10, 11, 34.000000, '2022-05-22 01:24:19');

-- ----------------------------
-- Table structure for pedido_venda_itens
-- ----------------------------
DROP TABLE IF EXISTS `pedido_venda_itens`;
CREATE TABLE `pedido_venda_itens`  (
  `ID` int NOT NULL AUTO_INCREMENT,
  `NR_PEDIDO` int NULL DEFAULT NULL,
  `CD_PRODUTO` int NULL DEFAULT NULL,
  `QUANTIDADE` decimal(16, 6) NULL DEFAULT NULL,
  `VALOR_UNITARIO` decimal(16, 6) NULL DEFAULT NULL,
  `VALOR_TOTAL` decimal(16, 6) NULL DEFAULT NULL,
  `DT_INCLUSAO` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`ID`) USING BTREE,
  INDEX `fk_pedido_venda`(`NR_PEDIDO` ASC) USING BTREE,
  CONSTRAINT `fk_pedido_venda` FOREIGN KEY (`NR_PEDIDO`) REFERENCES `pedido_venda` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 22 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of pedido_venda_itens
-- ----------------------------
INSERT INTO `pedido_venda_itens` VALUES (21, 10, 14, 1.000000, 34.000000, 34.000000, '2022-05-22 01:24:24');

-- ----------------------------
-- Table structure for produtos
-- ----------------------------
DROP TABLE IF EXISTS `produtos`;
CREATE TABLE `produtos`  (
  `ID` int NOT NULL AUTO_INCREMENT,
  `DESCRICAO` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `PRECO_VENDA` decimal(16, 6) NOT NULL,
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 21 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of produtos
-- ----------------------------
INSERT INTO `produtos` VALUES (1, 'PRODUTO 1', 15.000000);
INSERT INTO `produtos` VALUES (2, 'PRODUTO 2', 10.000000);
INSERT INTO `produtos` VALUES (3, 'PRODUTO 3', 25.000000);
INSERT INTO `produtos` VALUES (4, 'PRODUTO 4', 30.000000);
INSERT INTO `produtos` VALUES (5, 'PRODUTO 5', 15.000000);
INSERT INTO `produtos` VALUES (6, 'PRODUTO 6', 80.000000);
INSERT INTO `produtos` VALUES (7, 'PRODUTO 7', 150.000000);
INSERT INTO `produtos` VALUES (8, 'PRODUTO 8', 160.000000);
INSERT INTO `produtos` VALUES (9, 'PRODUTO 9', 150.000000);
INSERT INTO `produtos` VALUES (10, 'PRODTUO 10', 112.000000);
INSERT INTO `produtos` VALUES (11, 'PRODUTO 11', 19.000000);
INSERT INTO `produtos` VALUES (12, 'PRODUTO 12', 66.000000);
INSERT INTO `produtos` VALUES (13, 'PRODUTO 13', 1.000000);
INSERT INTO `produtos` VALUES (14, 'PRODUTO 14', 34.000000);
INSERT INTO `produtos` VALUES (15, 'PRODUTO 15', 98.000000);
INSERT INTO `produtos` VALUES (16, 'PRODUTO 16', 101.000000);
INSERT INTO `produtos` VALUES (17, 'PRODUTO 17', 30.000000);
INSERT INTO `produtos` VALUES (18, 'PRODUTO 18', 18.000000);
INSERT INTO `produtos` VALUES (19, 'PRODUTO 19', 10.000000);
INSERT INTO `produtos` VALUES (20, 'PRODUTO 20', 5.000000);

SET FOREIGN_KEY_CHECKS = 1;

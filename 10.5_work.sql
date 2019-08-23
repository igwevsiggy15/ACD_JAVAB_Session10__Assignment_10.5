CREATE TABLE `employeemanagementdb`.`leaves` (
  `leave_type` VARCHAR(10) NOT NULL CHECK("Permanent" OR "Temporary"),
  `paid_leaves` INT NOT NULL,
  `earned_leaves` INT NULL,
  `sick_leaves` INT NULL,
  `vacations` INT NOT NULL,
  PRIMARY KEY (`leave_type`));

INSERT INTO `employeemanagementdb`.`leaves` VALUES ("Permanent", 40, 5, 10, 15);
INSERT INTO `employeemanagementdb`.`leaves`(leave_type, paid_leaves, vacations) VALUES ("Temporary", 40, 15);


  CREATE TABLE `employeemanagementdb`.`employee` (
  `emp_id` INT NOT NULL AUTO_INCREMENT,
  `emp_name` VARCHAR(45) NOT NULL,
  `emp_type` VARCHAR(10) NOT NULL CHECK("Temporary" OR "Permanent"),
  `emp_phone` VARCHAR(45) NOT NULL,
  `emp_email` VARCHAR(45) NOT NULL,
  `emp_base_sal` DECIMAL NOT NULL,
  `emp_pf` DECIMAL GENERATED ALWAYS AS (`emp_base_sal` * .12),
  `emp_da` DECIMAL GENERATED ALWAYS AS (`emp_base_sal` * .6),
  `emp_allowances` DECIMAL GENERATED ALWAYS AS (`emp_base_sal` * .5),
  PRIMARY KEY (`emp_id`),
  INDEX `fk_emp_type_idx` (`emp_type` ASC) VISIBLE,
  CONSTRAINT `fk_emp_type`
    FOREIGN KEY (`emp_type`)
    REFERENCES `employeemanagementdb`.`leaves` (`leave_type`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
    
INSERT INTO `employeemanagementdb`.`employee`(emp_name, emp_type, emp_phone, emp_email, emp_base_sal) VALUES ("Iggy", "Permanent", "770-456-7890", "iggy15@gmail.com", 150000);
INSERT INTO `employeemanagementdb`.`employee`(emp_name, emp_type, emp_phone, emp_email, emp_base_sal) VALUES ("KK", "Temporary", "678-555-5656", "kk78963@aol.com", 80000);
INSERT INTO `employeemanagementdb`.`employee`(emp_name, emp_type, emp_phone, emp_email, emp_base_sal) VALUES ("Mike", "Permanent", "404-883-6921", "mike3012@verizon.com", 78000);
INSERT INTO `employeemanagementdb`.`employee`(emp_name, emp_type, emp_phone, emp_email, emp_base_sal) VALUES ("DJ", "Permanent", "678-789-1023", "dj789456@yahoo.com", 78000);
INSERT INTO `employeemanagementdb`.`employee`(emp_name, emp_type, emp_phone, emp_email, emp_base_sal) VALUES ("Paul", "Temporary", "770-115-3069", "paul1651@yahoo.com", 90000);

DROP TABLE `employeemanagementdb`.`employee`;
DROP TABLE `employeemanagementdb`.`leaves`;

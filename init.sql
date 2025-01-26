-- Create the Airflow database
CREATE DATABASE airflow;

-- Switch to the Airflow database
\c airflow;

-- Drop and recreate the neighborhood_pov table
DROP TABLE IF EXISTS "neighborhood_pov";
CREATE TABLE "neighborhood_pov" (
    "OBJECTID" INT PRIMARY KEY,           -- Unique identifier for the record
    "NAME" TEXT,                          -- Name of the school
    "NCESSCH" TEXT,                       -- Unique School ID
    "IPR_EST" INT,                        -- Income-to-poverty ratio estimate
    "IPR_SE" INT,                         -- Standard error for the income-to-poverty ratio
    "SCHOOLYEAR" TEXT,                    -- School year corresponding to the data
    "LAT" NUMERIC,                        -- Latitude of the school's location
    "LON" NUMERIC                         -- Longitude of the school's location
);

-- Drop and recreate the public school characteristics table
DROP TABLE IF EXISTS "public_school_characteristics";
CREATE TABLE "public_school_characteristics" (
    "OBJECTID" INT PRIMARY KEY,
    "NCESSCH" TEXT,                       -- Unique School ID
    "SURVYEAR" TEXT,                      -- Year corresponding to survey record
    "STABR" TEXT,                         -- Postal state abbreviation code
    "LEAID" TEXT,                         -- NCES Agency ID
    "ST_LEAID" TEXT,                      -- State Local Education Number
    "LEA_NAME" TEXT,                      -- Education Agency Name
    "SCH_NAME" TEXT,                      -- School Name
    "LSTREET1" TEXT,                      -- Location address, street 1
    "LSTREET2" TEXT,                      -- Location address, street 2
    "LCITY" TEXT,                         -- Location City
    "LSTATE" TEXT,                        -- Location State
    "LZIP" TEXT,                          -- Location 5-digit ZIP code
    "LZIP4" TEXT,                         -- Location Secondary ZIP code
    "PHONE" TEXT,                         -- Telephone number
    "CHARTER_TEXT" TEXT,                  -- Whether a Charter School
    "VIRTUAL" TEXT,                       -- Virtual School Status
    "GSLO" TEXT,                          -- Grades Offered - Lowest
    "GSHI" TEXT,                          -- Grades Offered - Highest
    "SCHOOL_LEVEL" TEXT,                  -- School level
    "STATUS" TEXT,                        -- Start of year status (code)
    "SCHOOL_TYPE_TEXT" TEXT,              -- School type (description)
    "SY_STATUS_TEXT" TEXT,                -- Start of year Status (description)
    "ULOCALE" TEXT,                       -- Locale Code
    "NMCNTY" TEXT,                        -- County Name
    "CNTY" TEXT,                          -- County FIPS
    "TOTFRL" INT,                         -- Total of free lunch and reduced-price lunch eligible
    "FRELCH" INT,                         -- Free Lunch Program
    "REDLCH" INT,                         -- Reduced-Lunch Program
    "DIRECTCERT" INT,                     -- Direct Certification
    "PK" INT,                             -- Prekindergarten students
    "KG" INT,                             -- Kindergarten students
    "G01" INT,                            -- Grade 1 students
    "G02" INT,                            -- Grade 2 students
    "G03" INT,                            -- Grade 3 students
    "G04" INT,                            -- Grade 4 students
    "G05" INT,                            -- Grade 5 students
    "G06" INT,                            -- Grade 6 students
    "G07" INT,                            -- Grade 7 students
    "G08" INT,                            -- Grade 8 students
    "G09" INT,                            -- Grade 9 students
    "G10" INT,                            -- Grade 10 students
    "G11" INT,                            -- Grade 11 students
    "G12" INT,                            -- Grade 12 students
    "G13" INT,                            -- Grade 13 students
    "UG" INT,                             -- Ungraded students
    "AE" INT,                             -- Adult Education Students
    "TOTMENROL" INT,                      -- Total Male Enrollment
    "TOTFENROL" INT,                      -- Total Female Enrollment
    "TOTAL" INT,                          -- Total students, all grades (includes AE)
    "MEMBER" INT,                         -- Total elementary/secondary students (excludes AE)
    "FTE" NUMERIC,                        -- Total Teachers (Full-Time Equivalent)
    "STUTERATIO" NUMERIC,                 -- Student-Teacher Ratio
    "AMALM" INT,                          -- All Students - American Indian/Alaska Native - Male
    "AMALF" INT,                          -- All Students - American Indian/Alaska Native - Female
    "AM" INT,                             -- All Students - American Indian/Alaska Native
    "ASALM" INT,                          -- All Students - Asian - Male
    "ASALF" INT,                          -- All Students - Asian - Female
    "AS_" INT,                            -- All Students - Asian
    "BLALM" INT,                          -- All Students - Black or African American - Male
    "BLALF" INT,                          -- All Students - Black or African American - Female
    "BL" INT,                             -- All Students - Black or African American
    "HPALM" INT,                          -- All Students - Native Hawai'ian or Other Pacific Islander - Male
    "HPALF" INT,                          -- All Students - Native Hawai'ian or Other Pacific Islander - Female
    "HP" INT,                             -- All Students - Native Hawai'ian or Other Pacific Islander
    "HIALM" INT,                          -- All Students - Hispanic - Male
    "HIALF" INT,                          -- All Students - Hispanic - Female
    "HI" INT,                             -- All Students - Hispanic
    "TRALM" INT,                          -- All Students - Two or More Races - Male
    "TRALF" INT,                          -- All Students - Two or More Races - Female
    "TR" INT,                             -- All Students - Two or More Races
    "WHALM" INT,                          -- All Students - White - Male
    "WHALF" INT,                          -- All Students - White - Female
    "WH" INT,                             -- All Students - White
    "LATCOD" NUMERIC,                     -- Latitude
    "LONCOD" NUMERIC                      -- Longitude
);




-- Create the table with the corrected column names
DROP TABLE IF EXISTS "private_school_locations";
CREATE TABLE "private_school_locations" (
    "OBJECTID" INT PRIMARY KEY,        -- Unique identifier for the record
    "PPIN" TEXT,                       -- School identification number
    "NAME" TEXT,                       -- Name of institution
    "STREET" TEXT,                     -- Location street address
    "CITY" TEXT,                       -- Location city
    "STATE" TEXT,                      -- Location state
    "ZIP" TEXT,                        -- Location ZIP code
    "STFIP" TEXT,                      -- Location State FIPS
    "CNTY" TEXT,                       -- County FIPS
    "NMCNTY" TEXT,                     -- County name
    "LOCALE" TEXT,                     -- Locale code
    "LAT" NUMERIC,                     -- Latitude of school location
    "LON" NUMERIC,                     -- Longitude of school location
    "CBSA" TEXT,                       -- Core Based Statistical Area
    "NMCBSA" TEXT,                     -- Core Based Statistical Area name
    "CBSATYPE" TEXT,                   -- Core Based Statistical Area type
    "CSA" TEXT,                        -- Combined Statistical Area
    "NMCSA" TEXT,                      -- Combined Statistical Area name
    "NECTA" TEXT,                      -- New England City and Town Area
    "NMNECTA" TEXT,                    -- New England City and Town Area name
    "CD" TEXT,                         -- 116th Congressional District
    "SLDL" TEXT,                       -- State Legislative District-Lower
    "SLDU" TEXT,                       -- State Legislative District-Upper
    "SCHOOLYEAR" TEXT                  -- School year
);

-- Drop and recreate the public school locations table
DROP TABLE IF EXISTS "public_school_locations";
CREATE TABLE "public_school_locations" (
    "OBJECTID" SERIAL PRIMARY KEY,        -- Unique identifier for the record
    "NCESSCH" TEXT,                       -- School identification number
    "LEAID" TEXT,                         -- School district identification number
    "NAME" TEXT,                          -- Name of institution
    "OPSTFIPS" TEXT,                      -- FIPS state code for operating state
    "STREET" TEXT,                        -- Reported location street address
    "CITY" TEXT,                          -- Reported location city
    "STATE" TEXT,                         -- Reported location state
    "ZIP" TEXT,                           -- Reported location ZIP code
    "STFIP" TEXT,                         -- State FIPS
    "CNTY" TEXT,                          -- County FIPS
    "NMCNTY" TEXT,                        -- County name
    "LOCALE" TEXT,                        -- Locale code
    "LAT" NUMERIC,                        -- Latitude of school location
    "LON" NUMERIC,                        -- Longitude of school location
    "CBSA" TEXT,                          -- Core Based Statistical Area
    "NMCBSA" TEXT,                        -- Core Based Statistical Area name
    "CBSATYPE" TEXT,                      -- Metropolitan or Micropolitan Statistical Area indicator
    "CSA" TEXT,                           -- Combined Statistical Area
    "NMCSA" TEXT,                         -- Combined Statistical Area name
    "NECTA" TEXT,                         -- New England City and Town Area
    "NMNECTA" TEXT,                       -- New England City and Town Area name
    "CD" TEXT,                            -- Congressional District
    "SLDL" TEXT,                          -- State Legislative District - Lower
    "SLDU" TEXT,                          -- State Legislative District - Upper
    "SCHOOLYEAR" TEXT                     -- School year corresponding to survey record
);

-- Drop and recreate the school_district_characteristics table
DROP TABLE IF EXISTS "school_district_characteristics";
CREATE TABLE "school_district_characteristics" (
    "OBJECTID" INT PRIMARY KEY,
    "SURVYEAR" TEXT,                      -- Survey year
    "STATENAME" TEXT,                     -- State name
    "LEAID" TEXT,                         -- Local Education Agency ID
    "ST_LEAID" TEXT,                      -- State Local Education Agency ID
    "LEA_NAME" TEXT,                      -- Local Education Agency Name
    "LSTREET1" TEXT,                      -- Location address, street 1
    "LSTREET2" TEXT,                      -- Location address, street 2
    "LCITY" TEXT,                         -- Location city
    "LSTATE" TEXT,                        -- Location state
    "LZIP" TEXT,                          -- Location ZIP code
    "LZIP4" TEXT,                         -- Location secondary ZIP code
    "LEA_TYPE_TEXT" TEXT,                 -- Local Education Agency type description
    "LEA_TYPE" NUMERIC,                   -- Local Education Agency type code
    "GSLO" TEXT,                          -- Grades Offered - Lowest
    "GSHI" TEXT,                          -- Grades Offered - Highest
    "SY_STATUS_TEXT" TEXT,                -- School Year Status description
    "SCH" INT,                            -- Number of schools
    "MEMBER" NUMERIC,                     -- Total elementary/ secondary students (excludes AE)
    "TOTTCH" NUMERIC,                     -- Total teachers
    "STUTERATIO" NUMERIC,                 -- Student-Teacher Ratio
    "LOCALE_TEXT" TEXT,                   -- Locale description
    "CONAME" TEXT,                        -- County name
    "COID" TEXT,                          -- County ID
    "PHONE" TEXT,                         -- Phone number
    "Lat" NUMERIC,                        -- Latitude of the LEA location
    "Long" NUMERIC,                       -- Longitude of the LEA location
    "Shape__Area" NUMERIC,                -- Area of the LEA in spatial terms
    "Shape__Length" NUMERIC               -- Perimeter length of the LEA in spatial terms
);

DROP TABLE IF EXISTS "school_district_boundaries";
CREATE TABLE "school_district_boundaries" (
    "OBJECTID" INT PRIMARY KEY,                           -- Object ID
    "STATEFP" VARCHAR(2),                                 -- State FIPS Code
    "ELSDLEA" VARCHAR(5),                                 -- Current elementary school district local education
    "SCSDLEA" VARCHAR(5),                                 -- Current secondary school district local education
    "UNSDLEA" VARCHAR(5),                                 -- Current unified school district local education
    "SDADMLEA" VARCHAR(5),                                -- Current administrative school district local
    "GEOID" VARCHAR(7),                                   -- School district identifier
    "NAME" VARCHAR(100),                                  -- Name
    "LSAD" VARCHAR(2),                                    -- Legal or statistical area description
    "LOGRADE" VARCHAR(2),                                 -- Lowest grade covered by school district
    "HIGRADE" VARCHAR(2),                                 -- Highest grade covered by school district
    "MTFCC" VARCHAR(5),                                   -- MAF/TIGER Feature Class Code
    "SDTYP" VARCHAR(1),                                   -- School District Type
    "FUNCSTAT" VARCHAR(1),                                -- Functional Status
    "ALAND" DOUBLE PRECISION,                             -- Land Area
    "AWATER" DOUBLE PRECISION,                            -- Water area
    "INTPTLAT" VARCHAR(11),                               -- Latitude of the internal point
    "INTPTLON" VARCHAR(12),                               -- Longitude of the internal point
    "GEO_YEAR" VARCHAR(4),                                -- TIGER Year
    "SCHOOLYEAR" VARCHAR(9),                              -- Academic Year
    "Shape__Area" DOUBLE PRECISION,                       -- Shape Area
    "Shape__Length" DOUBLE PRECISION                      -- Shape Length
);



-- Drop the table if it already exists
DROP TABLE IF EXISTS "student_assessment_results";

CREATE TABLE "student_assessment_results" (
    "County Code" TEXT,                               
    "District Code" TEXT,                             
    "District Name" TEXT,                             
    "School Code" TEXT,                               
    "School Name" TEXT,                               
    "Type ID" TEXT,                                   
    "Filler" TEXT,                                    
    "Test Year" TEXT,                                 
    "Test Type" TEXT,                                 
    "Test ID" TEXT,                                   
    "Student Group ID" TEXT,                          
    "Grade" TEXT,                                     
    "Total Students Enrolled" TEXT,                  
    "Total Students Tested" TEXT,                    
    "Total Students Tested with Scores" TEXT,        
    "Mean Scale Score" TEXT,                         
    "Percentage Standard Exceeded" TEXT,             
    "Count Standard Exceeded" TEXT,                  
    "Percentage Standard Met" TEXT,                  
    "Count Standard Met" TEXT,                       
    "Percentage Standard Met and Above" TEXT,        
    "Count Standard Met and Above" TEXT,             
    "Percentage Standard Nearly Met" TEXT,           
    "Count Standard Nearly Met" TEXT,                
    "Percentage Standard Not Met" TEXT,              
    "Count Standard Not Met" TEXT,                   
    "Overall Total" TEXT,                             
    "Area 1 Percentage Above Standard" TEXT,         
    "Area 1 Count Above Standard" TEXT,              
    "Area 1 Percentage Near Standard" TEXT,          
    "Area 1 Count Near Standard" TEXT,               
    "Area 1 Percentage Below Standard" TEXT,         
    "Area 1 Count Below Standard" TEXT,              
    "Area 1 Total" TEXT,                              
    "Area 2 Percentage Above Standard" TEXT,         
    "Area 2 Count Above Standard" TEXT,              
    "Area 2 Percentage Near Standard" TEXT,          
    "Area 2 Count Near Standard" TEXT,               
    "Area 2 Percentage Below Standard" TEXT,         
    "Area 2 Count Below Standard" TEXT,              
    "Area 2 Total" TEXT,                              
    "Area 3 Percentage Above Standard" TEXT,         
    "Area 3 Count Above Standard" TEXT,              
    "Area 3 Percentage Near Standard" TEXT,          
    "Area 3 Count Near Standard" TEXT,               
    "Area 3 Percentage Below Standard" TEXT,         
    "Area 3 Count Below Standard" TEXT,              
    "Area 3 Total" TEXT,                              
    "Area 4 Percentage Above Standard" TEXT,         
    "Area 4 Count Above Standard" TEXT,              
    "Area 4 Percentage Near Standard" TEXT,          
    "Area 4 Count Near Standard" TEXT,               
    "Area 4 Percentage Below Standard" TEXT,         
    "Area 4 Count Below Standard" TEXT,              
    "Area 4 Total" TEXT,                              
    "Composite Area 1 Percentage Above Standard" TEXT,
    "Composite Area 1 Count Above Standard" TEXT,    
    "Composite Area 1 Percentage Near Standard" TEXT, 
    "Composite Area 1 Count Near Standard" TEXT,     
    "Composite Area 1 Percentage Below Standard" TEXT,
    "Composite Area 1 Count Below Standard" TEXT,    
    "Composite Area 1 Total" TEXT,                   
    "Composite Area 2 Percentage Above Standard" TEXT,
    "Composite Area 2 Count Above Standard" TEXT,    
    "Composite Area 2 Percentage Near Standard" TEXT, 
    "Composite Area 2 Count Near Standard" TEXT,     
    "Composite Area 2 Percentage Below Standard" TEXT,
    "Composite Area 2 Count Below Standard" TEXT,    
    "Composite Area 2 Total" TEXT                    
);


DROP TABLE IF EXISTS "district_funding";

CREATE TABLE "district_funding" (
    "SVY_COMP" TEXT,
    "GOVTYPE" TEXT,
    "AGG_DESC_LABEL" TEXT,
    "AGG_DESC" TEXT,
    "FINSRC" TEXT,
    "ENROLLSZE" TEXT,
    "NAME" TEXT,
    "EXPENDTYPE" TEXT,
    "AMOUNT_PUPIL" TEXT,
    "AMOUNT" TEXT,
    "AMOUNT_CHANGE" TEXT,
    "YEAR" TEXT,
    "time" TEXT,
    "state" TEXT,
    "school district (unified)" TEXT
);

-- Drop table if it exists
DROP TABLE IF EXISTS "district_assessment_results";

-- Create the district_assessment_results table
CREATE TABLE "district_assessment_results" (
    "leaid" TEXT,
    "leaid_num" INT,
    "year" INT,
    "lea_name" TEXT,
    "fips" INT,
    "grade_edfacts" INT,
    "race" INT,
    "sex" INT,
    "lep" INT,
    "homeless" INT,
    "migrant" INT,
    "disability" INT,
    "foster_care" INT,
    "military_connected" INT,
    "econ_disadvantaged" INT,
    "read_test_num_valid" INT,
    "read_test_pct_prof_low" NUMERIC,
    "read_test_pct_prof_high" NUMERIC,
    "read_test_pct_prof_midpt" NUMERIC,
    "math_test_num_valid" INT,
    "math_test_pct_prof_low" NUMERIC,
    "math_test_pct_prof_high" NUMERIC,
    "math_test_pct_prof_midpt" NUMERIC
);

-- Drop the table if it already exists
DROP TABLE IF EXISTS "esser_cares";

-- Create the esser_cares table
CREATE TABLE "esser_cares" (
    "stateCode" TEXT,
    "reportingYear" TEXT,
    "entityName" TEXT,
    "dunsNumber" TEXT,
    "ueiNumber" TEXT,
    "ncesNumber" TEXT,
    "isLea" BOOLEAN,
    "esser1SeaReserveAwarded" NUMERIC,
    "esser1SeaReserveExpendedPrior" NUMERIC,
    "esser1SeaReserveExpendedCurrent" NUMERIC,
    "esser1SeaReserveUsedPhysical" VARCHAR,
    "esser1SeaReserveUsedAcademic" VARCHAR,
    "esser1SeaReserveUsedMental" VARCHAR,
    "esser1SeaReserveUsedOperational" VARCHAR,
    "esser1SeaReserveRemaining" NUMERIC,
    "esser1SeaReserveRemainingPhysical" NUMERIC,
    "esser1SeaReserveRemainingAcademic" NUMERIC,
    "esser1SeaReserveRemainingMental" NUMERIC,
    "esser1SeaReserveRemainingOperational" NUMERIC,
    "esser1SeaReserveRemainingUndetermined" NUMERIC,
    "esser1MandatorySubgrantAwarded" NUMERIC,
    "esser1MandatoryExpendedPrior" NUMERIC,
    "esser1MandatoryExpendedCurrent" NUMERIC,
    "esser1MandPhysicalExpendedTotal" NUMERIC,
    "esser1MandPhysicalPersonnelSalaries" NUMERIC,
    "esser1MandPhysicalPersonnelBenefits" NUMERIC,
    "esser1MandPhysicalTechnical" NUMERIC,
    "esser1MandPhysicalPropertyServices" NUMERIC,
    "esser1MandPhysicalOtherServices" NUMERIC,
    "esser1MandPhysicalSupplies" NUMERIC,
    "esser1MandPhysicalProperty" NUMERIC,
    "esser1MandPhysicalDebtService" NUMERIC,
    "esser1MandPhysicalOtherItems" NUMERIC,
    "esser1MandAcademicExpendedTotal" NUMERIC,
    "esser1MandAcademicPersonnelSalaries" NUMERIC,
    "esser1MandAcademicPersonnelBenefits" NUMERIC,
    "esser1MandAcademicTechnical" NUMERIC,
    "esser1MandAcademicPropertyServices" NUMERIC,
    "esser1MandAcademicOtherServices" NUMERIC,
    "esser1MandAcademicSupplies" NUMERIC,
    "esser1MandAcademicProperty" NUMERIC,
    "esser1MandAcademicDebtService" NUMERIC,
    "esser1MandAcademicOtherItems" NUMERIC,
    "esser1MandMentalExpendedTotal" NUMERIC,
    "esser1MandMentalPersonnelSalaries" NUMERIC,
    "esser1MandMentalPersonnelBenefits" NUMERIC,
    "esser1MandMentalTechnical" NUMERIC,
    "esser1MandMentalPropertyServices" NUMERIC,
    "esser1MandMentalOtherServices" NUMERIC,
    "esser1MandMentalSupplies" NUMERIC,
    "esser1MandMentalProperty" NUMERIC,
    "esser1MandMentalDebtService" NUMERIC,
    "esser1MandMentalOtherItems" NUMERIC,
    "esser1MandOperationalExpendedTotal" NUMERIC,
    "esser1MandOperationalPersonnelSalaries" NUMERIC,
    "esser1MandOperationalPersonnelBenefits" NUMERIC,
    "esser1MandOperationalTechnical" NUMERIC,
    "esser1MandOperationalPropertyServices" NUMERIC,
    "esser1MandOperationalOtherServices" NUMERIC,
    "esser1MandOperationalSupplies" NUMERIC,
    "esser1MandOperationalProperty" NUMERIC,
    "esser1MandOperationalDebtService" NUMERIC,
    "esser1MandOperationalOtherItems" NUMERIC,
    "esser1MandatoryRemaining" NUMERIC,
    "esser1MandatoryRemainingPhysical" NUMERIC,
    "esser1MandatoryRemainingAcademic" NUMERIC,
    "esser1MandatoryRemainingMental" NUMERIC,
    "esser1MandatoryRemainingOperational" NUMERIC,
    "esser1MandatoryRemainingUndetermined" NUMERIC
);

-- Drop the table if it already exists
DROP TABLE IF EXISTS "esser_crrsa";

-- Create the esser_crrsa table
CREATE TABLE "esser_crrsa" (
    "stateCode" TEXT,
    "reportingYear" TEXT,
    "entityName" TEXT,
    "dunsNumber" TEXT,
    "ueiNumber" TEXT,
    "ncesNumber" TEXT,
    "isLea" BOOLEAN,
    "esser2SeaReserveAwarded" NUMERIC,
    "esser2SeaReserveExpendedPrior" NUMERIC,
    "esser2SeaReserveExpendedCurrent" NUMERIC,
    "esser2SeaReserveUsedPhysical" VARCHAR,
    "esser2SeaReserveUsedAcademic" VARCHAR,
    "esser2SeaReserveUsedMental" VARCHAR,
    "esser2SeaReserveUsedOperational" VARCHAR,
    "esser2SeaReserveRemaining" NUMERIC,
    "esser2SeaReserveRemainingPhysical" NUMERIC,
    "esser2SeaReserveRemainingAcademic" NUMERIC,
    "esser2SeaReserveRemainingMental" NUMERIC,
    "esser2SeaReserveRemainingOperational" NUMERIC,
    "esser2SeaReserveRemainingUndetermined" NUMERIC,
    "esser2MandatorySubgrantAwarded" NUMERIC,
    "esser2MandatoryExpendedPrior" NUMERIC,
    "esser2MandatoryExpendedCurrent" NUMERIC,
    "esser2MandPhysicalExpendedTotal" NUMERIC,
    "esser2MandPhysicalPersonnelSalaries" NUMERIC,
    "esser2MandPhysicalPersonnelBenefits" NUMERIC,
    "esser2MandPhysicalTechnical" NUMERIC,
    "esser2MandPhysicalPropertyServices" NUMERIC,
    "esser2MandPhysicalOtherServices" NUMERIC,
    "esser2MandPhysicalSupplies" NUMERIC,
    "esser2MandPhysicalProperty" NUMERIC,
    "esser2MandPhysicalDebtService" NUMERIC,
    "esser2MandPhysicalOtherItems" NUMERIC,
    "esser2MandAcademicExpendedTotal" NUMERIC,
    "esser2MandAcademicPersonnelSalaries" NUMERIC,
    "esser2MandAcademicPersonnelBenefits" NUMERIC,
    "esser2MandAcademicTechnical" NUMERIC,
    "esser2MandAcademicPropertyServices" NUMERIC,
    "esser2MandAcademicOtherServices" NUMERIC,
    "esser2MandAcademicSupplies" NUMERIC,
    "esser2MandAcademicProperty" NUMERIC,
    "esser2MandAcademicDebtService" NUMERIC,
    "esser2MandAcademicOtherItems" NUMERIC,
    "esser2MandMentalExpendedTotal" NUMERIC,
    "esser2MandMentalPersonnelSalaries" NUMERIC,
    "esser2MandMentalPersonnelBenefits" NUMERIC,
    "esser2MandMentalTechnical" NUMERIC,
    "esser2MandMentalPropertyServices" NUMERIC,
    "esser2MandMentalOtherServices" NUMERIC,
    "esser2MandMentalSupplies" NUMERIC,
    "esser2MandMentalProperty" NUMERIC,
    "esser2MandMentalDebtService" NUMERIC,
    "esser2MandMentalOtherItems" NUMERIC,
    "esser2MandOperationalExpendedTotal" NUMERIC,
    "esser2MandOperationalPersonnelSalaries" NUMERIC,
    "esser2MandOperationalPersonnelBenefits" NUMERIC,
    "esser2MandOperationalTechnical" NUMERIC,
    "esser2MandOperationalPropertyServices" NUMERIC,
    "esser2MandOperationalOtherServices" NUMERIC,
    "esser2MandOperationalSupplies" NUMERIC,
    "esser2MandOperationalProperty" NUMERIC,
    "esser2MandOperationalDebtService" NUMERIC,
    "esser2MandOperationalOtherItems" NUMERIC,
    "esser2MandatoryRemaining" NUMERIC,
    "esser2MandatoryRemainingPhysical" NUMERIC,
    "esser2MandatoryRemainingAcademic" NUMERIC,
    "esser2MandatoryRemainingMental" NUMERIC,
    "esser2MandatoryRemainingOperational" NUMERIC,
    "esser2MandatoryRemainingUndetermined" NUMERIC
);

-- Drop the table if it already exists
DROP TABLE IF EXISTS "esser_arp";

-- Create the esser_arp table
CREATE TABLE "esser_arp" (
    "stateCode" TEXT,
    "reportingYear" TEXT,
    "entityName" TEXT,
    "dunsNumber" TEXT,
    "ueiNumber" TEXT,
    "ncesNumber" TEXT,
    "isLea" BOOLEAN,
    "esser3SeaReserveTotalAwarded" NUMERIC,
    "esser3SeaReserveTotalExpendedCurrent" NUMERIC,
    "esser3SeaReserveLostTimeAwarded" NUMERIC,
    "esser3SeaReserveLostTimeExpendedPrior" NUMERIC,
    "esser3SeaReserveLostTimeExpendedCurrent" NUMERIC,
    "esser3SeaReserveSummerAwarded" NUMERIC,
    "esser3SeaReserveSummerExpendedPrior" NUMERIC,
    "esser3SeaReserveSummerExpendedCurrent" NUMERIC,
    "esser3SeaReserveAftSchAwarded" NUMERIC,
    "esser3SeaReserveAftSchExpendedPrior" NUMERIC,
    "esser3SeaReserveAftSchExpendedCurrent" NUMERIC,
    "esser3SeaReserveOtherAwarded" NUMERIC,
    "esser3SeaReserveOtherExpendedPrior" NUMERIC,
    "esser3SeaReserveOtherExpendedCurrent" NUMERIC,
    "esser3SeaReserveUsedPhysical" VARCHAR,
    "esser3SeaReserveUsedAcademic" VARCHAR,
    "esser3SeaReserveUsedMental" VARCHAR,
    "esser3SeaReserveUsedOperational" VARCHAR,
    "esser3SeaReserveRemaining" NUMERIC,
    "esser3SeaReserveRemainingPhysical" VARCHAR,
    "esser3SeaReserveRemainingAcademic" VARCHAR,
    "esser3SeaReserveRemainingMental" VARCHAR,
    "esser3SeaReserveRemainingOperational" VARCHAR,
    "esser3SeaReserveRemainingUndetermined" NUMERIC,
    "esser3MandatorySubgrantAwarded" NUMERIC,
    "esser3MandatoryExpendedPrior" NUMERIC,
    "esser3MandatoryExpendedCurrent" NUMERIC,
    "esser3MandPhysicalExpendedTotal" NUMERIC,
    "esser3MandPhysicalPersonnelSalaries" NUMERIC,
    "esser3MandPhysicalPersonnelBenefits" NUMERIC,
    "esser3MandPhysicalTechnical" NUMERIC,
    "esser3MandPhysicalPropertyServices" NUMERIC,
    "esser3MandPhysicalOtherServices" NUMERIC,
    "esser3MandPhysicalSupplies" NUMERIC,
    "esser3MandPhysicalProperty" NUMERIC,
    "esser3MandPhysicalDebtService" NUMERIC,
    "esser3MandPhysicalOtherItems" NUMERIC,
    "esser3MandAcademicExpendedTotal" NUMERIC,
    "esser3MandAcademicPersonnelSalaries" NUMERIC,
    "esser3MandAcademicPersonnelBenefits" NUMERIC,
    "esser3MandAcademicTechnical" NUMERIC,
    "esser3MandAcademicPropertyServices" NUMERIC,
    "esser3MandAcademicOtherServices" NUMERIC,
    "esser3MandAcademicSupplies" NUMERIC,
    "esser3MandAcademicProperty" NUMERIC,
    "esser3MandAcademicDebtService" NUMERIC,
    "esser3MandAcademicOtherItems" NUMERIC,
    "esser3MandMentalExpendedTotal" NUMERIC,
    "esser3MandMentalPersonnelSalaries" NUMERIC,
    "esser3MandMentalPersonnelBenefits" NUMERIC,
    "esser3MandMentalTechnical" NUMERIC,
    "esser3MandMentalPropertyServices" NUMERIC,
    "esser3MandMentalOtherServices" NUMERIC,
    "esser3MandMentalSupplies" NUMERIC,
    "esser3MandMentalProperty" NUMERIC,
    "esser3MandMentalDebtService" NUMERIC,
    "esser3MandMentalOtherItems" NUMERIC,
    "esser3MandOperationalExpendedTotal" NUMERIC,
    "esser3MandOperationalPersonnelSalaries" NUMERIC,
    "esser3MandOperationalPersonnelBenefits" NUMERIC,
    "esser3MandOperationalTechnical" NUMERIC,
    "esser3MandOperationalPropertyServices" NUMERIC,
    "esser3MandOperationalOtherServices" NUMERIC,
    "esser3MandOperationalSupplies" NUMERIC,
    "esser3MandOperationalProperty" NUMERIC,
    "esser3MandOperationalDebtService" NUMERIC,
    "esser3MandOperationalOtherItems" NUMERIC,
    "esser3Mand20ExpendedPrior" NUMERIC,
    "esser3Mand20ExpendedCurrent" NUMERIC,
    "esser3Mand20PhysicalExpendedTotal" NUMERIC,
    "esser3Mand20PhysicalPersonnelSalaries" NUMERIC,
    "esser3Mand20PhysicalPersonnelBenefits" NUMERIC,
    "esser3Mand20PhysicalTechnical" NUMERIC,
    "esser3Mand20PhysicalPropertyServices" NUMERIC,
    "esser3Mand20PhysicalOtherServices" NUMERIC,
    "esser3Mand20PhysicalSupplies" NUMERIC,
    "esser3Mand20PhysicalProperty" NUMERIC,
    "esser3Mand20PhysicalDebtService" NUMERIC,
    "esser3Mand20PhysicalOtherItems" NUMERIC,
    "esser3Mand20AcademicExpendedTotal" NUMERIC,
    "esser3Mand20AcademicPersonnelSalaries" NUMERIC,
    "esser3Mand20AcademicPersonnelBenefits" NUMERIC,
    "esser3Mand20AcademicTechnical" NUMERIC,
    "esser3Mand20AcademicPropertyServices" NUMERIC,
    "esser3Mand20AcademicOtherServices" NUMERIC,
    "esser3Mand20AcademicSupplies" NUMERIC,
    "esser3Mand20AcademicProperty" NUMERIC,
    "esser3Mand20AcademicDebtService" NUMERIC,
    "esser3Mand20AcademicOtherItems" NUMERIC,
    "esser3Mand20MentalExpendedTotal" NUMERIC,
    "esser3Mand20MentalPersonnelSalaries" NUMERIC,
    "esser3Mand20MentalPersonnelBenefits" NUMERIC,
    "esser3Mand20MentalTechnical" NUMERIC,
    "esser3Mand20MentalPropertyServices" NUMERIC,
    "esser3Mand20MentalOtherServices" NUMERIC,
    "esser3Mand20MentalSupplies" NUMERIC,
    "esser3Mand20MentalProperty" NUMERIC,
    "esser3Mand20MentalDebtService" NUMERIC,
    "esser3Mand20MentalOtherItems" NUMERIC,
    "esser3Mand20OperationalExpendedTotal" NUMERIC,
    "esser3Mand20OperationalPersonnelSalaries" NUMERIC,
    "esser3Mand20OperationalPersonnelBenefits" NUMERIC,
    "esser3Mand20OperationalTechnical" NUMERIC,
    "esser3Mand20OperationalPropertyServices" NUMERIC,
    "esser3Mand20OperationalOtherServices" NUMERIC,
    "esser3Mand20OperationalSupplies" NUMERIC,
    "esser3Mand20OperationalProperty" NUMERIC,
    "esser3Mand20OperationalDebtService" NUMERIC,
    "esser3Mand20OperationalOtherItems" NUMERIC,
    "esser3MandatoryRemaining" NUMERIC,
    "esser3MandatoryRemainingPhysical" NUMERIC,
    "esser3MandatoryRemainingAcademic" NUMERIC,
    "esser3MandatoryRemainingMental" NUMERIC,
    "esser3MandatoryRemainingOperational" NUMERIC,
    "esser3MandatoryRemainingUndetermined" NUMERIC,
    "esser3Mand20Reserve" NUMERIC,
    "esser3Mand20ReserveExpendedCurrent" NUMERIC,
    "isEsser3Mand20Summer"  VARCHAR,
    "isEsser3Mand20AftSch"  VARCHAR,
    "isEsser3Mand20ExtendedTime" VARCHAR,
    "isEsser3Mand20Tutoring" VARCHAR,
    "isEsser3Mand20AddlTeachers" VARCHAR,
    "isEsser3Mand20StaffSocial" VARCHAR,
    "isEsser3Mand20StaffMental" VARCHAR,
    "isEsser3Mand20StaffStudentNeeds" VARCHAR,
    "isEsser3Mand20Screening" VARCHAR,
    "isEsser3Mand20Coordination" VARCHAR,
    "isEsser3Mand20EarlyChildhood" VARCHAR,
    "isEsser3Mand20Curriculum" VARCHAR,
    "isEsser3Mand20Capacity" VARCHAR,
    "isEsser3Mand20Other" VARCHAR
);



-- Drop the table if it exists
DROP TABLE IF EXISTS "district_funding_new";

-- Recreate the table with column names exactly as in your tab-delimited header
CREATE TABLE "district_funding_new" (
    "LEAID"      TEXT,
    "CENSUSID"   TEXT,
    "PID6"       TEXT,
    "UNIT_TYPE"  TEXT,
    "FIPST"      TEXT,
    "CONUM"      TEXT,
    "CSA"        TEXT,
    "CBSA"       TEXT,
    "NAME"       TEXT,
    "STNAME"     TEXT,
    "STABBR"     TEXT,
    "SCHLEV"     TEXT,
    "AGCHRT"     TEXT,
    "YEAR"       TEXT,
    "CCDNF"      TEXT,
    "CENFILE"    TEXT,
    "GSLO"       TEXT,
    "GSHI"       TEXT,

    "V33"        NUMERIC,
    "MEMBERSCH"  NUMERIC,
    "TOTALREV"   NUMERIC,
    "TFEDREV"    NUMERIC,
    "C14"        NUMERIC,
    "C15"        NUMERIC,
    "C19"        NUMERIC,
    "C22"        NUMERIC,
    "C23"        NUMERIC,
    "C26"        NUMERIC,
    "C27"        NUMERIC,
    "B11"        NUMERIC,
    "C20"        NUMERIC,
    "C25"        NUMERIC,
    "C36"        NUMERIC,
    "B10"        NUMERIC,
    "B12"        NUMERIC,
    "B14"        NUMERIC,
    "B13"        NUMERIC,
    "TSTREV"     NUMERIC,
    "C01"        NUMERIC,
    "C04"        NUMERIC,
    "C05"        NUMERIC,
    "C06"        NUMERIC,
    "C07"        NUMERIC,
    "C08"        NUMERIC,
    "C09"        NUMERIC,
    "C10"        NUMERIC,
    "C11"        NUMERIC,
    "C12"        NUMERIC,
    "C13"        NUMERIC,
    "C35"        NUMERIC,
    "C38"        NUMERIC,
    "C39"        NUMERIC,
    "TLOCREV"    NUMERIC,
    "T02"        NUMERIC,
    "T06"        NUMERIC,
    "T09"        NUMERIC,
    "T15"        NUMERIC,
    "T40"        NUMERIC,
    "T99"        NUMERIC,
    "D11"        NUMERIC,
    "D23"        NUMERIC,
    "A07"        NUMERIC,
    "A08"        NUMERIC,
    "A09"        NUMERIC,
    "A11"        NUMERIC,
    "A13"        NUMERIC,
    "A15"        NUMERIC,
    "A20"        NUMERIC,
    "A40"        NUMERIC,
    "U11"        NUMERIC,
    "U22"        NUMERIC,
    "U30"        NUMERIC,
    "U50"        NUMERIC,
    "U97"        NUMERIC,
    "C24"        NUMERIC,
    "TOTALEXP"   NUMERIC,
    "TCURELSC"   NUMERIC,
    "TCURINST"   NUMERIC,
    "E13"        NUMERIC,
    "V91"        NUMERIC,
    "V92"        NUMERIC,
    "TCURSSVC"   NUMERIC,
    "E17"        NUMERIC,
    "E07"        NUMERIC,
    "E08"        NUMERIC,
    "E09"        NUMERIC,
    "V40"        NUMERIC,
    "V45"        NUMERIC,
    "V90"        NUMERIC,
    "V85"        NUMERIC,
    "TCUROTH"    NUMERIC,
    "E11"        NUMERIC,
    "V60"        NUMERIC,
    "V65"        NUMERIC,
    "TNONELSE"   NUMERIC,
    "V70"        NUMERIC,
    "V75"        NUMERIC,
    "V80"        NUMERIC,
    "TCAPOUT"    NUMERIC,
    "F12"        NUMERIC,
    "G15"        NUMERIC,
    "K09"        NUMERIC,
    "K10"        NUMERIC,
    "K11"        NUMERIC,
    "L12"        NUMERIC,
    "M12"        NUMERIC,
    "Q11"        NUMERIC,
    "I86"        NUMERIC,
    "Z32"        NUMERIC,
    "Z33"        NUMERIC,
    "Z35"        NUMERIC,
    "Z36"        NUMERIC,
    "Z37"        NUMERIC,
    "Z38"        NUMERIC,
    "V11"        NUMERIC,
    "V13"        NUMERIC,
    "V15"        NUMERIC,
    "V17"        NUMERIC,
    "V21"        NUMERIC,
    "V23"        NUMERIC,
    "V37"        NUMERIC,
    "V29"        NUMERIC,
    "Z34"        NUMERIC,
    "V10"        NUMERIC,
    "V12"        NUMERIC,
    "V14"        NUMERIC,
    "V16"        NUMERIC,
    "V18"        NUMERIC,
    "V22"        NUMERIC,
    "V24"        NUMERIC,
    "V38"        NUMERIC,
    "V30"        NUMERIC,
    "V32"        NUMERIC,
    "V93"        NUMERIC,

    -- Underscore columns exactly as in tab-delimited headers (not F_19H, F_21F, etc.)
    "_19H"       NUMERIC,
    "_21F"       NUMERIC,
    "_31F"       NUMERIC,
    "_41F"       NUMERIC,
    "_61V"       NUMERIC,
    "_66V"       NUMERIC,

    "W01"        NUMERIC,
    "W31"        NUMERIC,
    "W61"        NUMERIC,
    "V95"        NUMERIC,
    "V02"        NUMERIC,
    "K14"        NUMERIC,
    "CE1"        NUMERIC,
    "CE2"        NUMERIC,
    "CE3"        NUMERIC,
    "SE1"        NUMERIC,
    "SE2"        NUMERIC,
    "SE3"        NUMERIC,
    "SE4"        NUMERIC,
    "SE5"        NUMERIC,
    "AR1"        NUMERIC,
    "AR1A"       NUMERIC,
    "AR1B"       NUMERIC,
    "AR2"        NUMERIC,
    "AR2A"       NUMERIC,
    "AR3"        NUMERIC,
    "AR6"        NUMERIC,
    "AR6A"       NUMERIC,
    "AE1"        NUMERIC,
    "AE1A"       NUMERIC,
    "AE1B"       NUMERIC,
    "AE1C"       NUMERIC,
    "AE1D"       NUMERIC,
    "AE1E"       NUMERIC,
    "AE1F"       NUMERIC,
    "AE1G"       NUMERIC,
    "AE2"        NUMERIC,
    "AE2A"       NUMERIC,
    "AE2B"       NUMERIC,
    "AE2C"       NUMERIC,
    "AE2D"       NUMERIC,
    "AE2E"       NUMERIC,
    "AE2F"       NUMERIC,
    "AE2G"       NUMERIC,
    "AE3"        NUMERIC,
    "AE4"        NUMERIC,
    "AE4A"       NUMERIC,
    "AE4B"       NUMERIC,
    "AE4C"       NUMERIC,
    "AE4D"       NUMERIC,
    "AE4E"       NUMERIC,
    "AE4F"       NUMERIC,
    "AE4G"       NUMERIC,
    "AE5"        NUMERIC,
    "AE6"        NUMERIC,
    "AE7"        NUMERIC,
    "AE8"        NUMERIC,
    "WEIGHT"     NUMERIC,

    "FL_V33"     TEXT,
    "FL_MEMBERSCH" TEXT,
    "FL_C14"     TEXT,
    "FL_C15"     TEXT,
    "FL_C19"     TEXT,
    "FL_C22"     TEXT,
    "FL_C23"     TEXT,
    "FL_C26"     TEXT,
    "FL_C27"     TEXT,
    "FL_B11"     TEXT,
    "FL_C20"     TEXT,
    "FL_C25"     TEXT,
    "FL_C36"     TEXT,
    "FL_B10"     TEXT,
    "FL_B12"     TEXT,
    "FL_B14"     TEXT,
    "FL_B13"     TEXT,
    "FL_C01"     TEXT,
    "FL_C04"     TEXT,
    "FL_C05"     TEXT,
    "FL_C06"     TEXT,
    "FL_C07"     TEXT,
    "FL_C08"     TEXT,
    "FL_C09"     TEXT,
    "FL_C10"     TEXT,
    "FL_C11"     TEXT,
    "FL_C12"     TEXT,
    "FL_C13"     TEXT,
    "FL_C35"     TEXT,
    "FL_C38"     TEXT,
    "FL_C39"     TEXT,
    "FL_T02"     TEXT,
    "FL_T06"     TEXT,
    "FL_T09"     TEXT,
    "FL_T15"     TEXT,
    "FL_T40"     TEXT,
    "FL_T99"     TEXT,
    "FL_D11"     TEXT,
    "FL_D23"     TEXT,
    "FL_A07"     TEXT,
    "FL_A08"     TEXT,
    "FL_A09"     TEXT,
    "FL_A11"     TEXT,
    "FL_A13"     TEXT,
    "FL_A15"     TEXT,
    "FL_A20"     TEXT,
    "FL_A40"     TEXT,
    "FL_U11"     TEXT,
    "FL_U22"     TEXT,
    "FL_U30"     TEXT,
    "FL_U50"     TEXT,
    "FL_U97"     TEXT,
    "FL_C24"     TEXT,
    "FL_E13"     TEXT,
    "FL_V91"     TEXT,
    "FL_V92"     TEXT,
    "FL_E17"     TEXT,
    "FL_E07"     TEXT,
    "FL_E08"     TEXT,
    "FL_E09"     TEXT,
    "FL_V40"     TEXT,
    "FL_V45"     TEXT,
    "FL_V90"     TEXT,
    "FL_V85"     TEXT,
    "FL_E11"     TEXT,
    "FL_V60"     TEXT,
    "FL_V65"     TEXT,
    "FL_V70"     TEXT,
    "FL_V75"     TEXT,
    "FL_V80"     TEXT,
    "FL_F12"     TEXT,
    "FL_G15"     TEXT,
    "FL_K09"     TEXT,
    "FL_K10"     TEXT,
    "FL_K11"     TEXT,
    "FL_L12"     TEXT,
    "FL_M12"     TEXT,
    "FL_Q11"     TEXT,
    "FL_I86"     TEXT,
    "FL_Z32"     TEXT,
    "FL_Z33"     TEXT,
    "FL_Z35"     TEXT,
    "FL_Z36"     TEXT,
    "FL_Z37"     TEXT,
    "FL_Z38"     TEXT,
    "FL_V11"     TEXT,
    "FL_V13"     TEXT,
    "FL_V15"     TEXT,
    "FL_V17"     TEXT,
    "FL_V21"     TEXT,
    "FL_V23"     TEXT,
    "FL_V37"     TEXT,
    "FL_V29"     TEXT,
    "FL_Z34"     TEXT,
    "FL_V10"     TEXT,
    "FL_V12"     TEXT,
    "FL_V14"     TEXT,
    "FL_V16"     TEXT,
    "FL_V18"     TEXT,
    "FL_V22"     TEXT,
    "FL_V24"     TEXT,
    "FL_V38"     TEXT,
    "FL_V30"     TEXT,
    "FL_V32"     TEXT,
    "FL_V93"     TEXT,
    "FL_19H"     TEXT,
    "FL_21F"     TEXT,
    "FL_31F"     TEXT,
    "FL_41F"     TEXT,
    "FL_61V"     TEXT,
    "FL_66V"     TEXT,
    "FL_W01"     TEXT,
    "FL_W31"     TEXT,
    "FL_W61"     TEXT,
    "FL_V95"     TEXT,
    "FL_V02"     TEXT,
    "FL_K14"     TEXT,
    "FL_CE1"     TEXT,
    "FL_CE2"     TEXT,
    "FL_CE3"     TEXT,
    "FL_SE1"     TEXT,
    "FL_SE2"     TEXT,
    "FL_SE3"     TEXT,
    "FL_SE4"     TEXT,
    "FL_SE5"     TEXT,
    "FL_AR1"     TEXT,
    "FL_AR1A"    TEXT,
    "FL_AR1B"    TEXT,
    "FL_AR2"     TEXT,
    "FL_AR2A"    TEXT,
    "FL_AR3"     TEXT,
    "FL_AR6"     TEXT,
    "FL_AR6A"    TEXT,
    "FL_AE1"     TEXT,
    "FL_AE1A"    TEXT,
    "FL_AE1B"    TEXT,
    "FL_AE1C"    TEXT,
    "FL_AE1D"    TEXT,
    "FL_AE1E"    TEXT,
    "FL_AE1F"    TEXT,
    "FL_AE1G"    TEXT,
    "FL_AE2"     TEXT,
    "FL_AE2A"    TEXT,
    "FL_AE2B"    TEXT,
    "FL_AE2C"    TEXT,
    "FL_AE2D"    TEXT,
    "FL_AE2E"    TEXT,
    "FL_AE2F"    TEXT,
    "FL_AE2G"    TEXT,
    "FL_AE3"     TEXT,
    "FL_AE4"     TEXT,
    "FL_AE4A"    TEXT,
    "FL_AE4B"    TEXT,
    "FL_AE4C"    TEXT,
    "FL_AE4D"    TEXT,
    "FL_AE4E"    TEXT,
    "FL_AE4F"    TEXT,
    "FL_AE4G"    TEXT,
    "FL_AE5"     TEXT,
    "FL_AE6"     TEXT,
    "FL_AE7"     TEXT,
    "FL_AE8"     TEXT
);







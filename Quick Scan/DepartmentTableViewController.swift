//
//  DepartmentTableViewController.swift
//  Quick Scan
//
//  Created by Austin Kibler on 6/7/16.
//  Copyright © 2016 FMOLHS. All rights reserved.
//

/*
    Description: Used to create the Department List.
 
    Completion Status: Complete!
*/

import UIKit

class DepartmentTableViewController: UITableViewController {
    
    // MARK: - Properties
    /*
     Features of the type table view controller.
     */
    
    // An array of arrays of strings that are the different departments sorted by type.
    var departmentTitles = [[ "FMOLHS",
        "FMOL-BIS Systems-3000-8239",
        "FMOL-Cain Inc-3100-8311",
        "FMOL-CCM-3500-4510",
        "FMOL-Clinical Info Svcs-3000-8233",
        "FMOL-Clinical Suppt Svcs-3000-8245",
        "FMOL-College Info Svcs-3000-8225",
        "FMOL-Corporate-3000-8311",
        "FMOL-Corporate-3500-8311",
        "FMOL-eFit-3000-8243",
        "FMOL-Finance-3000-8210",
        "FMOL-FMC-3500-6169",
        "FMOL-FMOLHS IS-3000-8235",
        "FMOL-Franciscan Lgl Svcs-3000-1250",
        "FMOL-FWHS Corp-3000-8045",
        "FMOL-Human Resources-3000-8371",
        "FMOL-IS FMOLHS-3000-8235",
        "FMOL-IS Support Center-3000-8242",
        "FMOL-IS-3500-8231",
        "FMOL-Lak Internal Audit-3000-8219",
        "FMOL-Lake Info Svcs-3000-8229",
        "FMOL-Lou Internal Audit-3000-8220",
        "FMOL-Lourdes Info Svcs-3000-8228",
        "FMOL-Materials Management-3000-8331",
        "FMOL-Mission & Quality-3000-7183",
        "FMOL-OCM-3500-4501",
        "FMOL-PACE Administration-3200-8310",
        "FMOL-PACE Baton Rouge-3200-4400",
        "FMOL-Project Mgmt Office-3000-8238",
        "FMOL-Stf Internal Audit-3000-8221",
        "FMOL-Tech Ops-3000-8241"],["Our Lady of the Lake",
        "LAKE-A/R LA Cath Hlth Asc-101-1305",
        "LAKE-Accounting-101-8210",
        "LAKE-Accounting-401-8210",
        "LAKE-Activity Department-401-8450",
        "LAKE-Acute Care Rehab-101-7085",
        "LAKE-ADC - State Grant-101-7141",
        "LAKE-Administration-101-8310",
        "LAKE-Administration-301-8310",
        "LAKE-Administration-401-8310",
        "LAKE-Administration-580-8305",
        "LAKE-Administration-740-8310",
        "LAKE-Administration-801-8310",
        "LAKE-Administration-802-8310",
        "LAKE-Administration-803-8310",
        "LAKE-Administration-804-8310",
        "LAKE-Admissions-101-8241",
        "LAKE-Adult Day Care-101-7041",
        "LAKE-Adult Day Care-101-7140",
        "LAKE-Aging Services-101-8325",
        "LAKE-Allergy/Immunology-101-4141",
        "LAKE-Alternative Medicine-101-8298",
        "LAKE-Anesthesiology-101-7080",
        "LAKE-Application Info Srv-101-8239",
        "LAKE-ASMP Pharmacy-580-7072",
        "LAKE-Beauty Shop-401-5092",
        "LAKE-Bed Control-101-8247",
        "LAKE-Bio Med-101-8079",
        "LAKE-Blood Bank-101-7026",
        "LAKE-Blood Comp Dist Ctr-101-7023",
        "LAKE-Blood Donor Ctr Lour-101-7022",
        "LAKE-Blood Donor-101-7025",
        "LAKE-Business Development-101-8303",
        "LAKE-Business Office-101-8221",
        "LAKE-Cafeteria-101-8053",
        "LAKE-Cardiac Surgery Unit-101-6144",
        "LAKE-Cardio Admin-101-7051",
        "LAKE-Cardio Vascular Lab-101-7034",
        "LAKE-Cardiology 1-101-6063",
        "LAKE-Cardiology 2-101-6064",
        "LAKE-Cardiology 3-101-7055",
        "LAKE-Cardiovas Amb Cntr-101-7054",
        "LAKE-Cardiovascular ICU-101-6142",
        "LAKE-Care Center-101-6226",
        "LAKE-Case Mgt Mental Heal-101-7189",
        "LAKE-CDU Nursing Unit-101-6065",
        "LAKE-Central Cardiac Mon-101-6044",
        "LAKE-Central Proc Dept-101-7009",
        "LAKE-Central Services-101-6251",
        "LAKE-CHF Clinic-101-7134",
        "LAKE-CHF-CP Observ Unit-101-7057",
        "LAKE-Child Assessment Cen-101-6034",
        "LAKE-Child Life-101-6037",
        "LAKE-Childrens Hosp Flex-101-6041",
        "LAKE-Childrens Supt Serv-101-6038",
        "LAKE-Client Relations-101-8308",
        "LAKE-Clinical Info Serv-101-8233",
        "LAKE-Clinical Research-101-8405",
        "LAKE-Comfort Care Program-101-8023",
        "LAKE-Comm Health Grant-101-8404",
        "LAKE-Comp Axial Tomogrphy-101-7042",
        "LAKE-Coronary Care Unit-101-6140",
        "LAKE-Corporate Comm-101-8315",
        "LAKE-Corporate Office-101-8311",
        "LAKE-Counselors TAU-101-7177",
        "LAKE-Crit Care Wait Room-101-6128",
        "LAKE-Critical Care-101-4299",
        "LAKE-Customer Service-101-8025",
        "LAKE-CVIU-101-7053",
        "LAKE-Dental-740-7089",
        "LAKE-Dietary TAU-101-8055",
        "LAKE-Dietary-101-8050",
        "LAKE-Dietary-580-8050",
        "LAKE-Eating Disorders-101-7178",
        "LAKE-Education-101-8020",
        "LAKE-EEG-101-7033",
        "LAKE-Elder Care Strategy-101-8408",
        "LAKE-Emergency Care Unit-101-6231",
        "LAKE-Emergency Room-580-6235",
        "LAKE-Employee Benefits-101-9710",
        "LAKE-Employee Hlth Serv-101-8381",
        "LAKE-Endoscopy-101-6216",
        "LAKE-Evac Pat Screening-101-6238",
        "LAKE-Express Admit-101-6047",
        "LAKE-Eye Bank-101-8040",
        "LAKE-Fake Recruiting-101-9999",
        "LAKE-Family Cntr Didesse-101-4170",
        "LAKE-Financial Operations-101-8215",
        "LAKE-Financial Sys Sup-101-8216",
        "LAKE-Fitness Facility-101-8321",
        "LAKE-Floats-101-6002",
        "LAKE-FMOL Risk Management-101-7187",
        "LAKE-Food Service-401-8050",
        "LAKE-Ger Behv Cntr-101-6156",
        "LAKE-Gift Shop-101-5096",
        "LAKE-Grad Medical Educat-101-8033",
        "LAKE-Grants & Research-101-8318",
        "LAKE-Guest Services-101-8095",
        "LAKE-Head and Neck Center-101-4307",
        "LAKE-Health and Safety-101-8301",
        "LAKE-Health Info Mgmt-101-7180",
        "LAKE-Health Promotions-101-8402",
        "LAKE-Hearing & Balance-101-4304",
        "LAKE-Hospitalist-101-4300",
        "LAKE-Housekeeping-101-8090",
        "LAKE-Housekeeping-401-8090",
        "LAKE-Housekeeping-801-8090",
        "LAKE-Housekeeping-802-8090",
        "LAKE-Housekeeping-803-8090",
        "LAKE-Human Resources-101-8371",
        "LAKE-Human Resources-401-8371",
        "LAKE-Immun Support Prog-101-7172",
        "LAKE-Immun Support Site-101-7173",
        "LAKE-Infection Control-101-7185",
        "LAKE-Inpatient Car Rehab-101-7050",
        "LAKE-Inst Review Board-101-8336",
        "LAKE-Internal Audit-101-8219",
        "LAKE-Intl Patient Serv-101-8323",
        "LAKE-IP Diabetes & Nutrit-101-6921",
        "LAKE-IP Wound & Ostomy-101-6266",
        "LAKE-IS Compliance-101-8238",
        "LAKE-IS Data Center-101-8235",
        "LAKE-IS Systems Security-101-8232",
        "LAKE-IT Grants-101-8234",
        "LAKE-IV Therapy-101-6260",
        "LAKE-Lab Administration-101-7010",
        "LAKE-Lab Chemistry-101-7015",
        "LAKE-Lab Hematology-101-7016",
        "LAKE-Lab Imaging Ascensio-101-7048",
        "LAKE-Lab Microbiology-101-7019",
        "LAKE-Lab Referrals-101-7021",
        "LAKE-Lab Venipuncture-101-7011",
        "LAKE-Laboratory-580-7031",
        "LAKE-Laboratory-740-7010",
        "LAKE-Lake Lab Services-101-7029",
        "LAKE-Lake Ped Gastroenter-101-4142",
        "LAKE-Lake Pediatrics-101-4136",
        "LAKE-Lake Phy Rev Cycle-101-8296",
        "LAKE-Lake Pri Care Watson-101-4134",
        "LAKE-Lake Pri Care Zachar-101-4126",
        "LAKE-Lake Weight Solution-101-4140",
        "LAKE-Lakewise 50-101-8320",
        "LAKE-Laundry-401-8110",
        "LAKE-Light Duty-401-6002",
        "LAKE-Linen Service-101-8110",
        "LAKE-LPCP Central Pro Off-101-8350",
        "LAKE-LPCP Network Pool-101-4999",
        "LAKE-LPCP South Baton Rou-101-4125",
        "LAKE-LTD-101-1",
        "LAKE-Magn Resonance Imag-101-7043",
        "LAKE-Mail Distribution-101-8355",
        "LAKE-Maintenance-401-8061",
        "LAKE-Maintenance-801-8061",
        "LAKE-Maintenance-802-8061",
        "LAKE-Maintenance-803-8061",
        "LAKE-Maintenance-804-8061",
        "LAKE-Managed Care-101-8307",
        "LAKE-Management Info Serv-101-8231",
        "LAKE-Marketing-101-8309",
        "LAKE-Maryville-101-1340",
        "LAKE-Med Inten Care Unit-101-6121",
        "LAKE-Med Staff Office-101-8312",
        "LAKE-Med Telemetry-101-6052",
        "LAKE-Medical Call Center-101-6234",
        "LAKE-Medical Management-101-7170",
        "LAKE-Medical Records-580-7181",
        "LAKE-Medical-Surgical CCU-101-6141",
        "LAKE-Medicare-401-6151",
        "LAKE-Medicine 1-101-6048",
        "LAKE-Medicine 3-101-6049",
        "LAKE-Medicine 4-101-6046",
        "LAKE-Medicine Service Lin-101-7190",
        "LAKE-Men Hlth Adolscnt-101-6158",
        "LAKE-Men Hlth Cope Dept-101-6163",
        "LAKE-Men Hlth Outpat Serv-101-4165",
        "LAKE-Men Hlth Social Serv-101-6164",
        "LAKE-Men Hlth Therapy-101-7094",
        "LAKE-Men's Health Clinic-101-4131",
        "LAKE-Mental Health Admn-101-6153",
        "LAKE-Mental Health Unit-101-6154",
        "LAKE-Mobile Virtual Criti-101-8342",
        "LAKE-Molecular Diag Lab-101-7020",
        "LAKE-NAN-101-6005",
        "LAKE-NBHD Clinic Sctvil-101-6230",
        "LAKE-Nephrology-101-6051",
        "LAKE-Neurology-101-6020",
        "LAKE-NeuroScience Serv Ln-101-8344",
        "LAKE-Non Inv Cardiac Lab-101-7035",
        "LAKE-Non Invs RCU-101-6119",
        "LAKE-Nuclear Medicine-101-7060",
        "LAKE-Nursing Admn-101-6000",
        "LAKE-Nursing Admn-401-6000",
        "LAKE-Nursing Supt CDT-101-6004",
        "LAKE-Nursing Supt Serv-101-6003",
        "LAKE-Nursing Unit 1-401-6154",
        "LAKE-Nursing Unit 2-401-6155",
        "LAKE-Nursing Unit 3-401-6156",
        "LAKE-Nursing-580-6010",
        "LAKE-Nutritional Service-101-6930",
        "LAKE-OLOL Plastics Clinic-101-4308",
        "LAKE-Oncology 5W-101-6058",
        "LAKE-Oncology OSCU-101-6057",
        "LAKE-Oncology Outpatient-101-6056",
        "LAKE-Oncology Research-101-6055",
        "LAKE-Oncology Support-101-6059",
        "LAKE-OP Diabetes & Nutrit-101-6920",
        "LAKE-OP Wound & Ostomy-101-6265",
        "LAKE-Oral Surgery-101-4310",
        "LAKE-Ortho Service Line-101-8339",
        "LAKE-Orthopedics-101-6060",
        "LAKE-Out Pat Rehab-101-7084",
        "LAKE-Outpat Clinic Supprt-101-7090",
        "LAKE-Outpatient Car Rehab-101-7037",
        "LAKE-Outreach Respiratory-101-6173",
        "LAKE-Pain Management Clin-101-7087",
        "LAKE-Pain Management-101-7088",
        "LAKE-Palliative Care-101-4309",
        "LAKE-Parish Nursing-101-8324",
        "LAKE-Pastoral Care-101-8314",
        "LAKE-Patient Scheduling-101-4138",
        "LAKE-Patient Scheduling-101-8245",
        "LAKE-PBX-101-8341",
        "LAKE-PCIS-101-8237",
        "LAKE-PCN 01-101-4101",
        "LAKE-PCN 02-101-4102",
        "LAKE-PCN 03-101-4103",
        "LAKE-PCN 07-101-4107",
        "LAKE-PCN 09-101-4109",
        "LAKE-PCN 10-101-4110",
        "LAKE-PCN 12-101-4112",
        "LAKE-PCN 15-101-4115",
        "LAKE-PCN 18-101-4118",
        "LAKE-PCN 19-101-4119",
        "LAKE-PCN 21-101-4121",
        "LAKE-PCN 22-101-4122",
        "LAKE-PCN 24-101-4124",
        "LAKE-PCN 25-101-4125",
        "LAKE-PCN 27-101-4127",
        "LAKE-PCN 28-101-4128",
        "LAKE-PCN 33-101-4133",
        "LAKE-PCN 36-101-4136",
        "LAKE-PCN 39-101-4139",
        "LAKE-PCN Administration-101-8299",
        "LAKE-PCN36-101-4136",
        "LAKE-Ped Inten Care Unit-101-6122",
        "LAKE-Pediatric ER Doctors-101-4302",
        "LAKE-Pediatric ER-101-6237",
        "LAKE-Pediatric Neurology-101-4303",
        "LAKE-Pediatric Pulmonolog-101-4301",
        "LAKE-Pediatrics 1-101-6036",
        "LAKE-Pediatrics 2-101-6033",
        "LAKE-Pediatrics 3-101-6032",
        "LAKE-Peds 4 Express Admit-101-6030",
        "LAKE-Peds 4 Express Unit-101-6030",
        "LAKE-Peds Endocrinologist-101-6031",
        "LAKE-Peds St. Francisvill-101-4135",
        "LAKE-Pet Scan-101-7038",
        "LAKE-Pharmacy MOP-101-7071",
        "LAKE-Pharmacy Technology-101-8408",
        "LAKE-Pharmacy-101-7070",
        "LAKE-Physical Medicine-740-7084",
        "LAKE-Plant Management-101-8061",
        "LAKE-Plaza Cafe-101-8059",
        "LAKE-Plt Main Hskpng-580-8091",
        "LAKE-Polysomography-101-7032",
        "LAKE-Pooled Staff Men Hea-101-6165",
        "LAKE-Post Anest Care Unit-101-6218",
        "LAKE-Post Surg Support Svcs-101-6061",
        "LAKE-Prem Radio Pharm-101-7061",
        "LAKE-Primary Care-740-4401",
        "LAKE-Prof Serv Billing-101-8222",
        "LAKE-Quality Management-101-7183",
        "LAKE-Rad Special Proc-101-7047",
        "LAKE-Rad Ultrasound-101-7045",
        "LAKE-Radiology-101-7040",
        "LAKE-Radiology-580-7039",
        "LAKE-Radiology-740-7040",
        "LAKE-Regulatory Managemen-101-7184",
        "LAKE-Rehab Physical Ther-101-7096",
        "LAKE-Rehabilitation Unit-101-6152",
        "LAKE-Reservation Center-101-8246",
        "LAKE-Respiratory Care-101-6171",
        "LAKE-Respiratory-580-6172",
        "LAKE-Revenue Management-101-8218",
        "LAKE-Risk Management-101-7186",
        "LAKE-Rural Health-580-4202",
        "LAKE-Same Day Surgery-101-6217",
        "LAKE-Security-101-8076",
        "LAKE-Sen Companion Prog-101-7175",
        "LAKE-SHP Grant HAART-101-8407",
        "LAKE-SHP Grant House Sppt-101-8406",
        "LAKE-Sisters-101-9999",
        "LAKE-SNF Physical Med-101-7086",
        "LAKE-Special Procedures-580-7047",
        "LAKE-St Ann IOP-101-7148",
        "LAKE-St Ann PHP-101-7142",
        "LAKE-St Clare-101-6155",
        "LAKE-St Jude Affl Clinic-101-4129",
        "LAKE-St. Bernard Clinic-740-4400",
        "LAKE-Sterile Proc & Distr-101-6252",
        "LAKE-Support Services-401-8241",
        "LAKE-Sur Evening/Night-101-6211",
        "LAKE-Sur General-101-6210",
        "LAKE-Sur Head & Neck-101-6198",
        "LAKE-Sur Neuro-101-6214",
        "LAKE-Sur Orthopedics-101-6215",
        "LAKE-Sur Otolaryngology-101-6202",
        "LAKE-Sur Perfusion Serv-101-6199",
        "LAKE-Sur Services Admn-101-6200",
        "LAKE-Sur Support Services-101-6203",
        "LAKE-Sur Urology-101-6204",
        "LAKE-Sur Vascular-101-6207",
        "LAKE-Surg Inten Care Unit-101-6120",
        "LAKE-Surg Materials Mngt-101-8330",
        "LAKE-Surg Waiting Room-101-6221",
        "LAKE-Surgery 1-101-6042",
        "LAKE-Surgery 2-101-6043",
        "LAKE-Surgery/Trauma Unit-101-6045",
        "LAKE-Surgery-Pediatrics-101-6197",
        "LAKE-Surgical Service Lin-101-8343",
        "LAKE-Talent Management-101-8029",
        "LAKE-TAU Inpatient Counse-101-7191",
        "LAKE-Technical Info Sys-101-8230",
        "LAKE-Telemedicine-101-6233",
        "LAKE-TNCC-101-6123",
        "LAKE-Tower PACU-101-6219",
        "LAKE-Tower Surg Wait Room-101-6222",
        "LAKE-Trans Care Unit-101-6151",
        "LAKE-Transcription-101-7188",
        "LAKE-Transport Team-101-6039",
        "LAKE-Transporters-101-8093",
        "LAKE-Trauma Specialist Pr-101-4137",
        "LAKE-Tulane Grant-101-8014",
        "LAKE-Urgent Care-740-4402",
        "LAKE-Voice Center-101-4306",
        "LAKE-Volunteer Services-101-8313",
        "LAKE-Web Strategy-101-8383"],["College",
        "COLL-Accerlated Nsg BR-601-8129",
        "COLL-Accerlated Nsg W Jef-601-8121",
        "COLL-Admin Shreveport-601-8101",
        "COLL-Admission Tulane-601-8146",
        "COLL-Admissions & Records-601-8131",
        "COLL-Admissions-601-8145",
        "COLL-ANS Program Tulane-601-8136",
        "COLL-Art & Science Tulane-601-8147",
        "COLL-Arts & Sciences Shrev-601-8142",
        "COLL-Business Office-601-8132",
        "COLL-Cert RN Anesthetist-601-8404",
        "COLL-Certified Nurse Ast-601-8412",
        "COLL-Community Trning Ctr-601-8149",
        "COLL-Continuing Comm Educ-601-8150",
        "COLL-Counseling-601-8135",
        "COLL-DHH Grants-601-8154",
        "COLL-Distance Learning-601-8106",
        "COLL-Div of Allied Health-601-8115",
        "COLL-Div of Gen Studies-601-8125",
        "COLL-Division of Nursing-601-8111",
        "COLL-Fed Workstudy Prog-601-8161",
        "COLL-Financial Aid-601-8133",
        "COLL-Forensic Science-601-8401",
        "COLL-Gerontology-601-8405",
        "COLL-Health And Safety-601-8103",
        "COLL-Health Career Inst-601-8148",
        "COLL-Healthcare Mgmt-601-8127",
        "COLL-Hlth Careers Trn Ins-601-8151",
        "COLL-Institutional Advan-601-8114",
        "COLL-Institutional Supprt-601-8107",
        "COLL-Learning Res Ctr-601-8109",
        "COLL-Library Tulane-601-8139",
        "COLL-Library-601-8144",
        "COLL-Long Term Care Admin-601-8406",
        "COLL-Medical Assistant-601-8413",
        "COLL-MR GERTRUDE PROF I-601-8170",
        "COLL-Mstr Sci in Nursing-601-8403",
        "COLL-Pharmacy Technology-601-8408",
        "COLL-Phlebotomy-601-8411",
        "COLL-Physician Assistant-601-8402",
        "COLL-Planning and Assessm-601-8104",
        "COLL-PN Shreveport-601-8141",
        "COLL-Presidents Office-601-8100",
        "COLL-Prg-Clin Lab Science-601-8116",
        "COLL-Prog-Emer Hlth Serv-601-8126",
        "COLL-Prog-Phys Ther Asst-601-8128",
        "COLL-Prog-Radiology Tech-601-8118",
        "COLL-Prog-Surgical Tech-601-8117",
        "COLL-Registrar's Office-601-8130",
        "COLL-SR A FITZSIMMONS PRO-601-8171",
        "COLL-Sr V Dorgan Profess-601-8180",
        "COLL-Student Org Shrev-601-8143",
        "COLL-Student Org. Tulane-601-8138",
        "COLL-Student Services-601-8134",
        "COLL-Therapeutic Massage-601-8407",
        "COLL-Vice Pres Acadm Affr-601-8102",
        "COLL-VP Support Serv-601-8113"]]
    var department: String!

    // Loads the table.
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    // Function from Apple to handle memory.
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    /*
     Defines how the table should be built
     */
    
    // Defines the number of sections in the table.
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return departmentTitles.count
    }
    
    // Defines the number of rows in a section.
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return departmentTitles[section].count - 1
    }

    // Function to build the cells.
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        cell.textLabel?.text = departmentTitles[indexPath.section][indexPath.row + 1]
        return cell
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String?{
        return departmentTitles[section][0]
    }
    
    // MARK: - Navigation
    /*
     Navigation to and from the page.
     */
    
    // Prepares data to be sent to a different page.
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let selectedIndexPath = tableView.indexPathForSelectedRow
        department = departmentTitles[(selectedIndexPath?.section)!][(selectedIndexPath?.row)! + 1]
    }
}

























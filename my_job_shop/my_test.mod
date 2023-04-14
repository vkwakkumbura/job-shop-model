/*********************************************
 * OPL 12.10.0.0 Model
 * Author: METROPOLITAN
 * Creation Date: Jan 9, 2021 at 6:21:44 PM
 *********************************************/
int nbJobs = ...;
int nbMchs = ...;

range Jobs = 0..nbJobs-1;
range Mchs = 0..nbMchs-1;
// Mchs is used both to index machines and operation position in job
//tuple Op {
//  int mc; // Machine
//  int p;  // Processing time
//};
//
//Op O[j in Jobs][m in Mchs] = ...;
tuple Operat {
  int mc; // Machine
  int pts;  // Processing time
};
 
Operat Op[j in Jobs][m in Mchs] = ...;





tuple Operation {
  int mch; // Machine
  int pt;  // Processing time
};
 
Operation Ops[j in Jobs,m in Mchs] = Operat[j,r];

//int Ops[j in Jobs, m in Mchs,r in Lvl] =nb2[j,r+nbLevels*(m-1)];

execute {
   writeln(Ops);
}; 
 
//{triple} Triples =  // feasible paths from spokes to spokes via one hub  
//{<r1.spoke,r1.hub,r2.spoke> | r1,r2 in Routes : r1 != r2 && r1.hub == r2.hub}; 
// 
/*********************************************
 * OPL 12.10.0.0 Model
 * Author: METROPOLITAN
 * Creation Date: Jan 8, 2021 at 6:49:19 AM
 *********************************************/
int nbJobs = ...;
int nbMchs = ...;
int nbLevels = ...;
range Jobs = 0..nbJobs-1;
range Mchs = 0..nbMchs-1;



// Mchs is used both to index machines and operation position in job

tuple Operation {
  int mch; // Machine
  int pt;  // Processing time
};

 

int nb2[1..nbJobs, 1..nbMchs*nbLevels] = ...;
int Opsf[m in 1..nbJobs, p in 1..nbMchs,s in 1..nbLevels] = nb2[m,s+nbLevels*(p-1)];



//int nb2[1..nbJobs, 1..nbMchs*nbLevels] = ...;
//{Operation} Ops = {<m,nb2[m,s+nbLevels*(p-1)> | m in 1..nbJobs, p in 1..nbMchs,s in 1..nbLevels};




dvar int+ s[j in Jobs][o in Mchs];
dexpr int e[j in Jobs][o in Mchs]=s[j][o]+Ops[j][o].pt;



minimize max(j in Jobs) e[j][nbMchs-1];
subject to {
  forall (m in Mchs,ordered i,j in Jobs, o1 in Mchs,o2 in Mchs:Ops[i][o1].mch == m && Ops[j][o2].mch == m)
    (e[i][o1]<=s[j][o2]) || (e[j][o2]<=s[i][o1]);
  forall (j in Jobs, o in 0..nbMchs-2)
    //endBeforeStart(itvs[j][o], itvs[j][o+1]);
    e[j][o]<=s[j][o+1];
}

execute {
  for (var j = 0; j <= nbJobs-1; j++) {
    for (var o = 0; o <= nbMchs-1; o++) {
      write(s[j][o] + " ");
    }
    writeln("");
  }
}
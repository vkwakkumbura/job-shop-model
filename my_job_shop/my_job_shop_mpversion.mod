/*********************************************
 * OPL 12.10.0.0 Model
 * Author: METROPOLITAN
 * Creation Date: Jan 7, 2021 at 7:00:19 PM
 *********************************************/
 
//****************************JOB SHOP SCHEDULING  ************************************** 
  
//********** Data *************
 
int nbJobs = ...;
int nbMchs = ...;

range Jobs = 0..nbJobs-1;
range Mchs = 0..nbMchs-1;    // NOTE:Mchs is used both to index machines and operation position in job



//******** Variables ********** 

tuple Operation {
  int mch; 					// Machine
  int pt;  					// Processing time--> Duration
};
 
Operation Ops[j in Jobs][m in Mchs] = ...;



//****************************Decision  Variables ************************************** 
 

dvar int+ start[j in Jobs][o in Mchs];


dexpr int  end[j in Jobs][o in Mchs]=   start[j][o] + Ops[j][o].pt;


dexpr int CompTime = max(j in Jobs) end[j][nbMchs-1];



//************ OBJECTIVE FUNCTION


minimize CompTime;







subject to {
  
  
  //Contaraint1
  
  forall (m in Mchs,ordered i,j in Jobs, o1 in Mchs,o2 in Mchs:Ops[i][o1].mch == m && Ops[j][o2].mch == m)
    
    ( end[i][o1]<= start[j][o2] ) || ( end[j][o2]<= start[i][o1] )  ;
     
  //Constraint2
    
  forall (j in Jobs, o in 0..nbMchs-2)
    
    end[j][o]<= start[j][o+1];
    
}


// Post- Processing

execute {
  for (var j = 0; j <= nbJobs-1; j++) {
    
    for (var o = 0; o <= nbMchs-1; o++) {
      write("("+start[j][o]+"-" +" " + end[j][o] +" )");
    }
    writeln("");
  }
}

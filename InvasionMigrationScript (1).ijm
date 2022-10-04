

input    = getDirectory("Choose input directory");
output = input;// + "results\\";  //create a folder called results
//input = "C:/Users/BethanySchaffer/Documents/Blenis_Postdoc/Notebook/e0358_10A_EMT_shNAGK#2_20190721/";
inputfiles = getFileList(input);

bildcount = 0;
//for (j=0; j < 5; j++) {   //have to have j here because the color threshold uses i
for (j=0; j < inputfiles.length; j++) {
          open(input+inputfiles[j]);
          imgName=getTitle(); 
          print(imgName);
		


run("Duplicate...", "title=image");
run("Duplicate...", "title=imagegreen");
selectWindow("image");
run("Median...", "radius=4");

run("Split Channels");

selectWindow("image (green)");
setAutoThreshold("Default dark");
//run("Threshold...");



//setThreshold(0, 80); // bethany: 4x migration images
setThreshold(0, 80); // bethany: 4x invasion images


run("Convert to Mask");
run("Set Measurements...", "area min display redirect=None decimal=5");
run("Create Selection");
//run("Make Inverse");
run("Measure");

//bildcount=0; ///SILENCE when running script


ar = getResult("Area", bildcount); //this is the value of area, taken from the resuts table
//wi=getWidth();
//dimentions=wi*hi;
dimentions=4915200;
per=(((dimentions-ar)/dimentions)*100);
//per=ar/dimentions*100;  //old way




setResult("Label", bildcount, ar);
setResult("Image name",bildcount,imgName);  //// add on again
setResult("Img Dimentions",bildcount,dimentions);
setResult("% covered",bildcount,per);




//calculate procentage change



selectWindow("image (green)");
run("Select None");
run("Scale...", "x=0.25 y=0.25 width=640 height=480 interpolation=Bilinear average create");
saveAs("tiff", output + "_area measured" + imgName + "_percentage_" + per);

run("Close All");

bildcount=bildcount+1;
//setResult("Label", bildcount, "All lysosomes");

          
          }


//open(input+inputfiles[1]);

//imgName=getTitle(); 

//print(imgName);
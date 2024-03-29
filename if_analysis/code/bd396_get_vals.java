// runMacro("/Users/briando/Documents/Projects/bd396_incucyte/bd396_get_vals.java")

setOption("ExpandableArrays", true)
setBatchMode(false); 

ofile = File.open("/Users/briando/Documents/Projects/bd396_incucyte/ltx2.csv")

name = getTitle();
print(name);
run("Make Substack...", "  slices=48");
print("hello")
setAutoThreshold("Triangle dark");
// run("Convert to Mask", "method=Triangle background=Dark calculate only black");
run("Analyze Particles...", "size=30-Infinity circularity=0.30-1.00 display exclude clear add"); 

num_roi = roiManager("count");
print(num_roi);

for (j=0; j<num_roi; j++) {
	selectWindow(name);
	roiManager("Select", j);
	run("Plot Z-axis Profile");
	Plot.getValues(xpoints, ypoints);
	str = "";
	for (p = 0; p < ypoints.length; p++) {
		str = str + d2s(ypoints[p], 2) + ",";
	}
	print(str + "\n");
	print(ofile, str + "\n");
	close();
}
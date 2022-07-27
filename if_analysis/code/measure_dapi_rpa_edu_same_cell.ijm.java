// to measure amount of DAPI signal and yH2AX signal + foci 
// 6/18/21

dir1 = getDirectory("Choose Source Directory ");
list = getFileList(dir1);
setOption("ExpandableArrays", true)
setBatchMode(false); // this is b/c we need to select ROI's 

ofile = File.open("")
print(ofile, "filename\tnum_maxima\tarea\tdapi\tedu\tmean_rpa\tstd_rpa\tcv_rpa\n")

for (i=0; i<list.length; i++) {

	// if (matches(list[i], ".R3D_D3D.dv")) {
	if (endsWith(list[i], "_R3D_D3D.dv")) {
		showProgress(i+1, list.length);
		// path = File.openDialog("Select a File");
		print(list[i]);

		filename = dir1 + list[i];
		s = "open=["+filename+"] autoscale color_mode=Default rois_import=[ROI manager] view=Hyperstack stack_order=XYCZT";
		run("Bio-Formats Importer", s);
		dir = File.getParent(filename);
		name = File.getName(filename);

		// make 3 files: "AVG_*", "MAX_*", and "max"
		selectWindow(name);
		// waitForUser("Find Z-stack range");

		start=1; end=20;
		// Dialog.create("Z-stack range");
		// Dialog.addNumber("Start:", start);
		// Dialog.addNumber("End:", end);
		// Dialog.show();
		// start = Dialog.getNumber();
		// end = Dialog.getNumber();
		run("Z Project...", "start=" + d2s(start,0) + " stop=" + d2s(end,0 ) + 
		" projection=[Max Intensity]");  // get max here
		selectWindow(name);
		run("Z Project...", "start=" + d2s(start,0) + " stop=" + d2s(end,0) + 
		" projection=[Average Intensity]");  // get avg here
		run("Duplicate...", "title=avg duplicate");

		// call cells in "max" using DAPI and send to ROI manager, then close "max"
		selectWindow("avg");
		run("8-bit");
		Stack.setDisplayMode("grayscale");
		Stack.setChannel(1);
		run("Sharpen", "slice");
		run("8-bit");
		setAutoThreshold("Default dark");
		//run("Threshold...");
		//setThreshold(77, 255);
		setOption("BlackBackground", true);
		run("Convert to Mask", "method=Shanbhag background=Dark calculate only black");
		run("Watershed", "slice");

		run("Analyze Particles...", "size=500-15000 pixel circularity=0.50-1.00 display exclude clear add slice");
		selectWindow("avg");
		close();

		// subtract background for average
		selectWindow("AVG_" + name);
		run("Subtract Background...", "rolling=50 slice");

		// get foci
		selectWindow("MAX_" + name);

		// can delete ROIs as necessary 
		old_num_roi = roiManager("count");
		roiManager("show all with labels");
		waitForUser("Select ROIs");

		// instantiating variables
		area = 0;
		mean_dapi = 0;
		mean_rpa = 0;
		std_rpa = 0;
		mean_edu = 0;
		num_roi = 0;

		// looping through each ROI
		num_roi = roiManager("count");  // new number after deletions
		print(num_roi);

		for (j=0; j<num_roi; j++) {

			// get # of foci
			selectWindow("MAX_" + name);
			roiManager("Select", j);
			Stack.setDisplayMode("grayscale");
			Stack.setChannel(2);
			// run("Find Maxima...", "prominence=300 output=[Point Selection]");
			// getSelectionCoordinates(x, y);
			run("Find Maxima...", "prominence=300 output=[Count]");

			// the number of ROIs is placed in the results, and the number of maxima are placed after that
			// rows are zero indexed
			n = getResult("Count", old_num_roi+j);   // there were old_num_roi of old ROIs
			print(n);	

			// get means and areas; no need to subtract background 
			selectWindow("AVG_" + name);
			roiManager("Select", j);

			Stack.setDisplayMode("grayscale");
			Stack.setChannel(1);
			getStatistics(area, mean_dapi);
			Stack.setChannel(2);
			getStatistics(area, mean_rpa, _, __, std_rpa);
			Stack.setChannel(4);
			getStatistics(area, mean_edu);

			// print statistics
			print(ofile, list[i] + '\t' + d2s(n,0) + "\t" + d2s(area,3) + "\t" + d2s(mean_dapi,3) + 
				"\t" + d2s(mean_edu,3) + "\t" +  d2s(mean_rpa,3) + "\t" +  d2s(std_rpa,3) +
				"\t" +  d2s(std_rpa/mean_rpa,3) + "\n");
		}

		// close remaining windows
		selectWindow("MAX_" + name);
		close();
		selectWindow("AVG_" + name);
		close();
		selectWindow(name);
		close();
	}

}

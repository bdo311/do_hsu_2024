dir1 = getDirectory("Choose Source Directory ");
list = getFileList(dir1);
setBatchMode(true);
setOption("ExpandableArrays", true)

for (i=0; i<list.length; i++) {
	if (endsWith(list[i], "/")) {
		subDir = dir1 + list[i];
		subList = getFileList(subDir); 
		for (j=0; j<subList.length; j++) {
			filename = subDir + subList[j];
			print(subList[j]);

			print(filename);
			// open(filename); // open the file

			run("Bio-Formats Importer", "open=[" + filename + "] series_1");
			dir = File.getParent(filename);
			name = File.getName(filename);

			//selectImage(name + " - " + name + " #1");
			//selectImage(name);
			run("Subtract Background...", "rolling=200");

			if (endsWith(filename, "mDAPI.tif")) {
				run("Gaussian Blur...", "sigma=2");
			}

			ofile = substring(name,0,lengthOf(name)-4);
			saveAs("Tiff", subDir + "/" + ofile + "_v2.tif");
			close();
		}
	}

}

/*Plots histograms for a multi-channel multi-slice image as a composite overlay.
(You still have to change the desired channel colors in your output histogram to 
match the input.)
Things to note/be careful of:
1. Fiji may rescale histograms, so comparisons of histogram height are not absolute.
2. This relies on pulling a specific region of the fiji-generated histogram. If the 
histogram output changes in the future, the makeRectangle line will need to be fixed accordingly. 
*/
origim=getTitle();
getDimensions(width, height, channels, slices, frames);

newImage("hists", "8-bit black", 258, 129, slices*channels);
run("Stack to Hyperstack...", "order=xyczt(default) channels="+channels+" slices="+slices+" frames=1 display=Composite");

for(i=1;i<=slices;i++){
	for(ch=1;ch<=channels;ch++){
		selectWindow(origim);
	    Stack.setSlice(i); 
		Stack.setChannel(ch);
		run("Histogram", "slice");
		makeRectangle(19, 10, 258, 129);
		run("8-bit");
		run("Invert");
		run("Copy");
		selectWindow("hists");
		Stack.setChannel(ch);
		Stack.setSlice(i); 
		run("Paste");
		selectWindow("Histogram of "+origim);
		close();
	}
}


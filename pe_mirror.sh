#!/bin/bash -xv
#
# This script will create a local mirror of pe
#

# our main mirror base
DEST=/tmp/

# PE files, 2.8+ 
SRC_HOST=pe-releases.puppetlabs.lan
SRC_URL=http://$SRC_HOST/

cd $DEST
if [ $? -ne 0 ]; then
	echo "Can't cd to $DEST";
else
	wget --mirror -p --no-parent --convert-links \
		-X 1.*,2.0*,2.5*,2.6*,2.7*,2.8.0*,2.8.1*,2.8.2*,3.0.0*,icons \
		$SRC_URL
	# Some cleanup
	find $DEST/$SRC_HOST -name "*C=[DMNS];O=[AD]" -exec rm -f "{}" \;
fi

# Training, and other downloads
SRC_HOST=downloads.puppetlabs.com
URLS="training docs"
EXCL="dashboard,development,enterprise,facter,geppetto,hiera,junos,mac,mcollective,nightly,puppet,puppetdb,razor,solaris,windows,tmp,learning"
FEXCL='*-pe-2.*,centos-6.3-pe-3.0.0-*'

cd $DEST
if [ $? -ne 0 ]; then
	echo "Can't cd to $DEST";
else
	for URI in $URLS; do
		SRC_URL=https://$SRC_HOST/$URI
		wget --mirror -p --no-parent --convert-links \
			-X icons,$EXCL \
      -R $FEXCL \
			$SRC_URL
		# Some cleanup
		find $DEST/$SRC_HOST -name "*C=[DMNS];O=[AD]" -exec rm -f "{}" \;
    rm -f $DEST/$SRC_HOST/{docs,training}.* $DEST/$SRC_HOST/training/index.html
	done
fi

# Int Resources - prelease training
SRC_HOST=int-resources.ops.puppetlabs.net
URLS="prosvc/training/VMs"
EXCL='centos-5*'

cd $DEST
if [ $? -ne 0 ]; then
	echo "Can't cd to $DEST";
else
	for URI in $URLS; do
		SRC_URL=http://$SRC_HOST/$URI
		wget --mirror -p --no-parent --convert-links \
			-X icons \
      -R $EXCL \
			$SRC_URL
		# Some cleanup
		find $DEST/$SRC_HOST -name "*C=[DMNS];O=[AD]" -exec rm -f "{}" \;
	done
fi


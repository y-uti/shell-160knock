makerepo() {
    dir=$1
    mkdir $dir
    (
	cd $dir
	echo "# $(basename $dir)" >README.md
	git init .
	git add README.md
	git commit -m "Initial commit"
    )
    echo "Initialized empty Git repository in $dir"
}

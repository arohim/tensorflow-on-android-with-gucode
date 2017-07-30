mkdir 20baht 100baht
./ffmpeg -i 20baht_frontside.mp4 -vf fps=5 20baht/a_%d.jpg &
./ffmpeg -i 20baht_backside.mp4 -vf fps=5 20baht/b_%d.jpg &
./ffmpeg -i 100baht_frontside.mp4 -vf fps=5 100baht/a_%d.jpg &
./ffmpeg -i 100baht_backside.mp4 -vf fps=5 100baht/b_%d.jpg
mv 20baht ../datasets
mv 100baht ../datasets
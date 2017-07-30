# scripts
mkdir tf_files

cd tf_files

git clone https://github.com/googlecodelabs/tensorflow-for-poets-2 tensorflow

mv tensorflow/scripts/ .

docker run -it \
  --publish 6006:6006 \
  --volume ${HOME}/Documents/gucode/tf_files:/tf_files \
  --workdir /gucode \
  tensorflow/tensorflow:1.1.0 bash

python scripts/retrain.py \
  --bottleneck_dir=bottlenecks \
  --model_dir=inception \
  --output_graph=retrained_graph.pb \
  --output_labels=retrained_labels.txt \
  --image_dir=datasets

python -m scripts.label_image \
  datasets/mouse/a1.jpg \
  gucode_graph.pb

python -m tensorflow.python.tools.optimize_for_inference \
  --input=retrained_graph.pb \
  --output=optimized_graph.pb \
  --input_names="Cast" \
  --output_names="final_result"

python -m scripts.quantize_graph \
  --input=optimized_graph.pb \
  --output=rounded_graph.pb \
  --output_node_names=final_result \
  --mode=weights_rounded

python -m tensorflow.scripts.label_image \
  datasets/mouse/a1.jpg \
  rounded_graph.pb
  
# References
- https://www.tensorflow.org/mobile/
- https://www.tensorflow.org/tutorials/image_retraining#bottlenecks
- https://www.youtube.com/watch?v=EnFyneRScQ8
- https://www.tensorflow.org/get_started/get_started
- https://codelabs.developers.google.com/codelabs/tensorflow-for-poets/
- https://codelabs.developers.google.com/codelabs/tensorflow-for-poets-2/
- https://stackoverflow.com/questions/40088222/ffmpeg-convert-video-to-images
- https://codelabs.developers.google.com/codelabs/tensorflow-for-poets/index.html?index=..%2F..%2Findex#4
- http://www.cs.unc.edu/~wliu/papers/GoogLeNet.pdf

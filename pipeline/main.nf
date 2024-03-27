#!/usr/bin/env nextflow
// hash:sha256:d22d5d0349140e2940377dcbc2993e62e0b350a3d691b43a7189c02c5a4b775e

nextflow.enable.dsl = 1

params.multiplane_ophys_485152_2019_12_09_13_04_09_url = 's3://aind-ophys-data/multiplane-ophys_485152_2019-12-09_13-04-09'

multiplane_ophys_485152_2019_12_09_13_04_09_to_aind_ophys_motion_correction_1 = channel.fromPath(params.multiplane_ophys_485152_2019_12_09_13_04_09_url + "/*/ophys_experiment*", type: 'any')
multiplane_ophys_485152_2019_12_09_13_04_09_to_aind_ophys_motion_correction_2 = channel.fromPath(params.multiplane_ophys_485152_2019_12_09_13_04_09_url + "/*.json", type: 'any')
multiplane_ophys_485152_2019_12_09_13_04_09_to_aind_ophys_motion_correction_3 = channel.fromPath(params.multiplane_ophys_485152_2019_12_09_13_04_09_url + "/*/MESOSCOPE_FILE*", type: 'any')
multiplane_ophys_485152_2019_12_09_13_04_09_to_aind_ophys_motion_correction_4 = channel.fromPath(params.multiplane_ophys_485152_2019_12_09_13_04_09_url + "/*/*.h5", type: 'any')
multiplane_ophys_485152_2019_12_09_13_04_09_to_aind_ophys_motion_correction_5 = channel.fromPath(params.multiplane_ophys_485152_2019_12_09_13_04_09_url + "/*/*platform.json", type: 'any')
capsule_aind_ophys_motion_correction_1_to_capsule_aind_ophys_decrosstalk_split_2_6 = channel.create()
multiplane_ophys_485152_2019_12_09_13_04_09_to_aind_ophys_decrosstalk_split_7 = channel.fromPath(params.multiplane_ophys_485152_2019_12_09_13_04_09_url + "/pophys/*MESOSCOPE*", type: 'any')
capsule_aind_ophys_motion_correction_1_to_capsule_aind_ophys_decrosstalk_roi_images_3_8 = channel.create()
capsule_aind_ophys_decrosstalk_split_2_to_capsule_aind_ophys_decrosstalk_roi_images_3_9 = channel.create()
capsule_aind_ophys_decrosstalk_roi_images_3_to_capsule_aind_ophys_segmentation_cellpose_4_10 = channel.create()
capsule_aind_ophys_motion_correction_1_to_capsule_aind_ophys_trace_extraction_5_11 = channel.create()
capsule_aind_ophys_decrosstalk_roi_images_3_to_capsule_aind_ophys_trace_extraction_5_12 = channel.create()
capsule_aind_ophys_segmentation_cellpose_4_to_capsule_aind_ophys_trace_extraction_5_13 = channel.create()

// capsule - aind-ophys-motion-correction
process capsule_aind_ophys_motion_correction_1 {
	tag 'capsule-5379831'
	container "$REGISTRY_HOST/capsule/63a8ce2e-f232-4590-9098-36b820202911"

	cpus 16
	memory '128 GB'

	publishDir "$RESULTS_PATH", saveAs: { filename -> new File(filename).getName() }

	input:
	path 'capsule/data/' from multiplane_ophys_485152_2019_12_09_13_04_09_to_aind_ophys_motion_correction_1
	path 'capsule/data/' from multiplane_ophys_485152_2019_12_09_13_04_09_to_aind_ophys_motion_correction_2.collect()
	path 'capsule/data/' from multiplane_ophys_485152_2019_12_09_13_04_09_to_aind_ophys_motion_correction_3.collect()
	path 'capsule/data/' from multiplane_ophys_485152_2019_12_09_13_04_09_to_aind_ophys_motion_correction_4.collect()
	path 'capsule/data/' from multiplane_ophys_485152_2019_12_09_13_04_09_to_aind_ophys_motion_correction_5.collect()

	output:
	path 'capsule/results/*'
	path 'capsule/results/*' into capsule_aind_ophys_motion_correction_1_to_capsule_aind_ophys_decrosstalk_split_2_6
	path 'capsule/results/*' into capsule_aind_ophys_motion_correction_1_to_capsule_aind_ophys_decrosstalk_roi_images_3_8
	path 'capsule/results/*' into capsule_aind_ophys_motion_correction_1_to_capsule_aind_ophys_trace_extraction_5_11

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=63a8ce2e-f232-4590-9098-36b820202911
	export CO_CPUS=16
	export CO_MEMORY=137438953472

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	git clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-5379831.git" capsule-repo
	git -C capsule-repo checkout b6ef8af0a8438fadca0411e0e49bbcff50154d66 --quiet
	mv capsule-repo/code capsule/code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run --debug

	echo "[${task.tag}] completed!"
	"""
}

// capsule - aind-ophys-decrosstalk-split
process capsule_aind_ophys_decrosstalk_split_2 {
	tag 'capsule-0299374'
	container "$REGISTRY_HOST/capsule/08588d21-5a40-420f-b1a1-e2e755709e54"

	cpus 1
	memory '8 GB'

	input:
	path 'capsule/data/' from capsule_aind_ophys_motion_correction_1_to_capsule_aind_ophys_decrosstalk_split_2_6.collect()
	path 'capsule/data/' from multiplane_ophys_485152_2019_12_09_13_04_09_to_aind_ophys_decrosstalk_split_7.collect()

	output:
	path 'capsule/results/*' into capsule_aind_ophys_decrosstalk_split_2_to_capsule_aind_ophys_decrosstalk_roi_images_3_9

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=08588d21-5a40-420f-b1a1-e2e755709e54
	export CO_CPUS=1
	export CO_MEMORY=8589934592

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	git clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-0299374.git" capsule-repo
	git -C capsule-repo checkout 34fa4a5f7d2ef9ece951d864b77346d77257a9c9 --quiet
	mv capsule-repo/code capsule/code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run

	echo "[${task.tag}] completed!"
	"""
}

// capsule - aind-ophys-decrosstalk-roi-images
process capsule_aind_ophys_decrosstalk_roi_images_3 {
	tag 'capsule-4612268'
	container "$REGISTRY_HOST/capsule/e31d29f8-7eee-446b-8f0a-2f027fe6f39b"

	cpus 16
	memory '128 GB'

	publishDir "$RESULTS_PATH", saveAs: { filename -> new File(filename).getName() }

	input:
	path 'capsule/data/' from capsule_aind_ophys_motion_correction_1_to_capsule_aind_ophys_decrosstalk_roi_images_3_8
	path 'capsule/data/' from capsule_aind_ophys_decrosstalk_split_2_to_capsule_aind_ophys_decrosstalk_roi_images_3_9.collect()

	output:
	path 'capsule/results/*'
	path 'capsule/results/*' into capsule_aind_ophys_decrosstalk_roi_images_3_to_capsule_aind_ophys_segmentation_cellpose_4_10
	path 'capsule/results/*' into capsule_aind_ophys_decrosstalk_roi_images_3_to_capsule_aind_ophys_trace_extraction_5_12

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=e31d29f8-7eee-446b-8f0a-2f027fe6f39b
	export CO_CPUS=16
	export CO_MEMORY=137438953472

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	git clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-4612268.git" capsule-repo
	git -C capsule-repo checkout 2b78a6dffc9ca4203fc0f34355d017ab33a38370 --quiet
	mv capsule-repo/code capsule/code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run

	echo "[${task.tag}] completed!"
	"""
}

// capsule - aind-ophys-segmentation-cellpose
process capsule_aind_ophys_segmentation_cellpose_4 {
	tag 'capsule-0136322'
	container "$REGISTRY_HOST/capsule/84e6b3e3-e24b-450e-b275-589fc229087e"

	cpus 2
	memory '16 GB'

	publishDir "$RESULTS_PATH", saveAs: { filename -> new File(filename).getName() }

	input:
	path 'capsule/data/' from capsule_aind_ophys_decrosstalk_roi_images_3_to_capsule_aind_ophys_segmentation_cellpose_4_10.flatten()

	output:
	path 'capsule/results/*'
	path 'capsule/results/*' into capsule_aind_ophys_segmentation_cellpose_4_to_capsule_aind_ophys_trace_extraction_5_13

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=84e6b3e3-e24b-450e-b275-589fc229087e
	export CO_CPUS=2
	export CO_MEMORY=17179869184

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	git clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-0136322.git" capsule-repo
	git -C capsule-repo checkout 15a8310d8db4a7c65e3ef02278a4f0b45b2820fe --quiet
	mv capsule-repo/code capsule/code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run

	echo "[${task.tag}] completed!"
	"""
}

// capsule - aind-ophys-trace-extraction
process capsule_aind_ophys_trace_extraction_5 {
	tag 'capsule-8581031'
	container "$REGISTRY_HOST/capsule/b70049b4-83c2-4c40-aecf-7bae689e4b6a"

	cpus 1
	memory '8 GB'

	publishDir "$RESULTS_PATH", saveAs: { filename -> new File(filename).getName() }

	input:
	path 'capsule/data/' from capsule_aind_ophys_motion_correction_1_to_capsule_aind_ophys_trace_extraction_5_11.collect()
	path 'capsule/data/' from capsule_aind_ophys_decrosstalk_roi_images_3_to_capsule_aind_ophys_trace_extraction_5_12.collect()
	path 'capsule/data/' from capsule_aind_ophys_segmentation_cellpose_4_to_capsule_aind_ophys_trace_extraction_5_13

	output:
	path 'capsule/results/*'

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=b70049b4-83c2-4c40-aecf-7bae689e4b6a
	export CO_CPUS=1
	export CO_MEMORY=8589934592

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	git clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-8581031.git" capsule-repo
	git -C capsule-repo checkout 914f78e3f883e748a5febfba566f8ea772de6483 --quiet
	mv capsule-repo/code capsule/code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run

	echo "[${task.tag}] completed!"
	"""
}

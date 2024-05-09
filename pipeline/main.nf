#!/usr/bin/env nextflow
// hash:sha256:1d1aaa6636dfbacf976e5124d4399a7ff6ea9a19466e164ecb21d24279bc5cf2

nextflow.enable.dsl = 1

params.multiplane_ophys_717824_2024_05_07_09_18_34_url = 's3://aind-private-data-prod-o5171v/multiplane-ophys_717824_2024-05-07_09-18-34'

capsule_aind_ophys_mesoscope_image_splitter_10_to_capsule_aind_ophys_motion_correction_1_1 = channel.create()
multiplane_ophys_717824_2024_05_07_09_18_34_to_aind_ophys_motion_correction_2 = channel.fromPath(params.multiplane_ophys_717824_2024_05_07_09_18_34_url + "/*.json", type: 'any')
multiplane_ophys_717824_2024_05_07_09_18_34_to_aind_ophys_motion_correction_3 = channel.fromPath(params.multiplane_ophys_717824_2024_05_07_09_18_34_url + "/ophys/*platform.json", type: 'any')
multiplane_ophys_717824_2024_05_07_09_18_34_to_aind_ophys_motion_correction_4 = channel.fromPath(params.multiplane_ophys_717824_2024_05_07_09_18_34_url + "/ophys/*.h5", type: 'any')
multiplane_ophys_717824_2024_05_07_09_18_34_to_aind_ophys_decrosstalk_split_session_json_5 = channel.fromPath(params.multiplane_ophys_717824_2024_05_07_09_18_34_url + "/session.json", type: 'any')
capsule_aind_ophys_motion_correction_1_to_capsule_aind_ophys_decrosstalk_split_session_json_2_6 = channel.create()
capsule_aind_ophys_motion_correction_1_to_capsule_aind_ophys_decrosstalk_roi_images_3_7 = channel.create()
capsule_aind_ophys_decrosstalk_split_session_json_2_to_capsule_aind_ophys_decrosstalk_roi_images_3_8 = channel.create()
capsule_aind_ophys_decrosstalk_roi_images_3_to_capsule_aind_ophys_segmentation_cellpose_4_9 = channel.create()
capsule_aind_ophys_decrosstalk_roi_images_3_to_capsule_aind_ophys_trace_extraction_5_10 = channel.create()
capsule_aind_ophys_motion_correction_1_to_capsule_aind_ophys_trace_extraction_5_11 = channel.create()
capsule_aind_ophys_segmentation_cellpose_4_to_capsule_aind_ophys_trace_extraction_5_12 = channel.create()
capsule_aind_ophys_decrosstalk_roi_images_3_to_capsule_aind_ophys_neuropil_correction_7_13 = channel.create()
capsule_aind_ophys_trace_extraction_5_to_capsule_aind_ophys_neuropil_correction_7_14 = channel.create()
capsule_aind_ophys_neuropil_correction_7_to_capsule_aind_ophys_dff_8_15 = channel.create()
capsule_aind_ophys_dff_8_to_capsule_aind_ophys_oasis_event_detection_9_16 = channel.create()
multiplane_ophys_717824_2024_05_07_09_18_34_to_aind_ophys_mesoscope_image_splitter_17 = channel.fromPath(params.multiplane_ophys_717824_2024_05_07_09_18_34_url + "/", type: 'any')

// capsule - aind-ophys-motion-correction
process capsule_aind_ophys_motion_correction_1 {
	tag 'capsule-5379831'
	container "$REGISTRY_HOST/capsule/63a8ce2e-f232-4590-9098-36b820202911"

	cpus 16
	memory '128 GB'

	publishDir "$RESULTS_PATH", saveAs: { filename -> filename.matches("capsule/results/motion_correction") ? new File(filename).getName() : null }

	input:
	path 'capsule/data/' from capsule_aind_ophys_mesoscope_image_splitter_10_to_capsule_aind_ophys_motion_correction_1_1.flatten()
	path 'capsule/data/' from multiplane_ophys_717824_2024_05_07_09_18_34_to_aind_ophys_motion_correction_2.collect()
	path 'capsule/data/' from multiplane_ophys_717824_2024_05_07_09_18_34_to_aind_ophys_motion_correction_3.collect()
	path 'capsule/data/' from multiplane_ophys_717824_2024_05_07_09_18_34_to_aind_ophys_motion_correction_4.collect()

	output:
	path 'capsule/results/motion_correction'
	path 'capsule/results/*' into capsule_aind_ophys_motion_correction_1_to_capsule_aind_ophys_decrosstalk_split_session_json_2_6
	path 'capsule/results/*' into capsule_aind_ophys_motion_correction_1_to_capsule_aind_ophys_decrosstalk_roi_images_3_7
	path 'capsule/results/*/motion_correction/*transform.csv' into capsule_aind_ophys_motion_correction_1_to_capsule_aind_ophys_trace_extraction_5_11

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
	git -C capsule-repo checkout f957764e4578449823580a8c55d0608306a5018e --quiet
	mv capsule-repo/code capsule/code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run --debug

	echo "[${task.tag}] completed!"
	"""
}

// capsule - aind-ophys-decrosstalk-split-session-json
process capsule_aind_ophys_decrosstalk_split_session_json_2 {
	tag 'capsule-7511402'
	container "$REGISTRY_HOST/capsule/76b52bbc-5e23-4e4b-9bc7-f48d24031e09"

	cpus 1
	memory '8 GB'

	input:
	path 'capsule/data/' from multiplane_ophys_717824_2024_05_07_09_18_34_to_aind_ophys_decrosstalk_split_session_json_5.collect()
	path 'capsule/data/' from capsule_aind_ophys_motion_correction_1_to_capsule_aind_ophys_decrosstalk_split_session_json_2_6.collect()

	output:
	path 'capsule/results/*' into capsule_aind_ophys_decrosstalk_split_session_json_2_to_capsule_aind_ophys_decrosstalk_roi_images_3_8

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=76b52bbc-5e23-4e4b-9bc7-f48d24031e09
	export CO_CPUS=1
	export CO_MEMORY=8589934592

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	git clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-7511402.git" capsule-repo
	git -C capsule-repo checkout 855e5c5bbc7942fca99af8146dfbb7d77153661e --quiet
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

	publishDir "$RESULTS_PATH/decrosstalk", saveAs: { filename -> filename.matches("capsule/results/decrosstalk") ? new File(filename).getName() : null }

	input:
	path 'capsule/data/' from capsule_aind_ophys_motion_correction_1_to_capsule_aind_ophys_decrosstalk_roi_images_3_7.collect()
	path 'capsule/data/' from capsule_aind_ophys_decrosstalk_split_session_json_2_to_capsule_aind_ophys_decrosstalk_roi_images_3_8.flatten()

	output:
	path 'capsule/results/decrosstalk/*'
	path 'capsule/results/*' into capsule_aind_ophys_decrosstalk_roi_images_3_to_capsule_aind_ophys_segmentation_cellpose_4_9
	path 'capsule/results/*/decrosstalk/*decrosstalk.h5' into capsule_aind_ophys_decrosstalk_roi_images_3_to_capsule_aind_ophys_trace_extraction_5_10
	path 'capsule/results/*/decrosstalk/*decrosstalk.h5' into capsule_aind_ophys_decrosstalk_roi_images_3_to_capsule_aind_ophys_neuropil_correction_7_13

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
	git -C capsule-repo checkout d8e03a2f40304863789615c380055c1932e97bf6 --quiet
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

	publishDir "$RESULTS_PATH/segmentation", saveAs: { filename -> filename.matches("capsule/results/segmentation") ? new File(filename).getName() : null }

	input:
	path 'capsule/data/' from capsule_aind_ophys_decrosstalk_roi_images_3_to_capsule_aind_ophys_segmentation_cellpose_4_9.flatten()

	output:
	path 'capsule/results/segmentation'
	path 'capsule/results/*' into capsule_aind_ophys_segmentation_cellpose_4_to_capsule_aind_ophys_trace_extraction_5_12

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
	git -C capsule-repo checkout b465c52f2beebcf4389daa613be71c8ac7a8bcc4 --quiet
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
	tag 'capsule-7385227'
	container "$REGISTRY_HOST/capsule/3821c170-5883-48ed-a2d5-4a627a432f18"

	cpus 1
	memory '8 GB'

	publishDir "$RESULTS_PATH/trace_extraction", saveAs: { filename -> filename.matches("capsule/results/trace_extraction") ? new File(filename).getName() : null }

	input:
	path 'capsule/data/' from capsule_aind_ophys_decrosstalk_roi_images_3_to_capsule_aind_ophys_trace_extraction_5_10.collect()
	path 'capsule/data/' from capsule_aind_ophys_motion_correction_1_to_capsule_aind_ophys_trace_extraction_5_11.collect()
	path 'capsule/data/' from capsule_aind_ophys_segmentation_cellpose_4_to_capsule_aind_ophys_trace_extraction_5_12

	output:
	path 'capsule/results/trace_extraction'
	path 'capsule/results/*' into capsule_aind_ophys_trace_extraction_5_to_capsule_aind_ophys_neuropil_correction_7_14

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=3821c170-5883-48ed-a2d5-4a627a432f18
	export CO_CPUS=1
	export CO_MEMORY=8589934592

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	git clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-7385227.git" capsule-repo
	git -C capsule-repo checkout 5dbbaa4ad8ac6132391b6c5fd9546924fe64ee14 --quiet
	mv capsule-repo/code capsule/code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run

	echo "[${task.tag}] completed!"
	"""
}

// capsule - aind-ophys-neuropil-correction
process capsule_aind_ophys_neuropil_correction_7 {
	tag 'capsule-7531658'
	container "$REGISTRY_HOST/capsule/7b9dcdd9-4f54-405b-974c-c4c9e405ce26"

	cpus 1
	memory '8 GB'

	publishDir "$RESULTS_PATH/neuropil_correction", saveAs: { filename -> filename.matches("capsule/results/neuropil_correction") ? new File(filename).getName() : null }

	input:
	path 'capsule/data/' from capsule_aind_ophys_decrosstalk_roi_images_3_to_capsule_aind_ophys_neuropil_correction_7_13.collect()
	path 'capsule/data/' from capsule_aind_ophys_trace_extraction_5_to_capsule_aind_ophys_neuropil_correction_7_14

	output:
	path 'capsule/results/neuropil_correction'
	path 'capsule/results/*' into capsule_aind_ophys_neuropil_correction_7_to_capsule_aind_ophys_dff_8_15

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=7b9dcdd9-4f54-405b-974c-c4c9e405ce26
	export CO_CPUS=1
	export CO_MEMORY=8589934592

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	git clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-7531658.git" capsule-repo
	git -C capsule-repo checkout ba521d6e038eb9dfba3e78701c8378496658f605 --quiet
	mv capsule-repo/code capsule/code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run

	echo "[${task.tag}] completed!"
	"""
}

// capsule - aind-ophys-dff
process capsule_aind_ophys_dff_8 {
	tag 'capsule-5186816'
	container "$REGISTRY_HOST/capsule/4d1bad07-ff45-4e69-a50f-874e840cd7e6"

	cpus 1
	memory '8 GB'

	publishDir "$RESULTS_PATH/dff", saveAs: { filename -> filename.matches("capsule/results/dff") ? new File(filename).getName() : null }

	input:
	path 'capsule/data/' from capsule_aind_ophys_neuropil_correction_7_to_capsule_aind_ophys_dff_8_15

	output:
	path 'capsule/results/dff/*'
	path 'capsule/results/*' into capsule_aind_ophys_dff_8_to_capsule_aind_ophys_oasis_event_detection_9_16

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=4d1bad07-ff45-4e69-a50f-874e840cd7e6
	export CO_CPUS=1
	export CO_MEMORY=8589934592

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	git clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-5186816.git" capsule-repo
	git -C capsule-repo checkout 492ccdb7e76d10cf5740812526505d0c795105e8 --quiet
	mv capsule-repo/code capsule/code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run

	echo "[${task.tag}] completed!"
	"""
}

// capsule - aind-ophys-oasis-event-detection
process capsule_aind_ophys_oasis_event_detection_9 {
	tag 'capsule-0298748'
	container "$REGISTRY_HOST/capsule/382062c4-fd31-4812-806b-cc81bad29bf4"

	cpus 1
	memory '8 GB'

	publishDir "$RESULTS_PATH/events", saveAs: { filename -> filename.matches("capsule/results/events") ? new File(filename).getName() : null }

	input:
	path 'capsule/data/' from capsule_aind_ophys_dff_8_to_capsule_aind_ophys_oasis_event_detection_9_16

	output:
	path 'capsule/results/events'

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=382062c4-fd31-4812-806b-cc81bad29bf4
	export CO_CPUS=1
	export CO_MEMORY=8589934592

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	git clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-0298748.git" capsule-repo
	git -C capsule-repo checkout 2b5d6f2beaf5d954739c81ed62750f74cdfbc646 --quiet
	mv capsule-repo/code capsule/code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run

	echo "[${task.tag}] completed!"
	"""
}

// capsule - aind-ophys-mesoscope-image-splitter
process capsule_aind_ophys_mesoscope_image_splitter_10 {
	tag 'capsule-0115380'
	container "$REGISTRY_HOST/capsule/c567666c-dd08-45dd-a824-6a570bd4675d"

	cpus 4
	memory '32 GB'

	input:
	path 'capsule/data' from multiplane_ophys_717824_2024_05_07_09_18_34_to_aind_ophys_mesoscope_image_splitter_17.collect()

	output:
	path 'capsule/results/.*/[0-9.]+' into capsule_aind_ophys_mesoscope_image_splitter_10_to_capsule_aind_ophys_motion_correction_1_1

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=c567666c-dd08-45dd-a824-6a570bd4675d
	export CO_CPUS=4
	export CO_MEMORY=34359738368

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	git clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-0115380.git" capsule-repo
	git -C capsule-repo checkout 96bf77c1fe8a210de1ace68a4d426c8f8a7a8b7c --quiet
	mv capsule-repo/code capsule/code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run

	echo "[${task.tag}] completed!"
	"""
}

#!/usr/bin/env nextflow
// hash:sha256:2d993cea68670b11882c764937ddb059bcba089acc6b116e78377e4ca8a69ad7

nextflow.enable.dsl = 1

params.ophys_mount_url = 's3://aind-private-data-prod-o5171v/multiplane-ophys_749013_2024-11-13_14-42-09'

mount_to_motion_correction_jsons = channel.fromPath(params.ophys_mount_url + "/*json", type: 'any')
mount_to_motion_correction_sync = channel.fromPath(params.ophys_mount_url + "/*/*.h5", type: 'any')
image_splitter_to_motion_correction = channel.create()
motion_correction_to_decrosstalk_split = channel.create()
mount_to_decrosstalk_split_session_json = channel.fromPath(params.ophys_mount_url + "/session.json", type: 'any')
decrosstalk_split_json_to_decrosstalk = channel.create()
image_splitter_to_decrosstalk = channel.create()
mount_to_decrosstalk_jsons = channel.fromPath(params.ophys_mount_url + "/*.json", type: 'any')
motion_correction_to_decrosstalk = channel.create()
mount_to_extraction_jsons = channel.fromPath(params.ophys_mount_url + "/*.json", type: 'any')
decrosstalk_to_extraction = channel.create()
mount_to_dff_jsons = channel.fromPath(params.ophys_mount_url + "/*.json", type: 'any')
extraction_to_dff = channel.create()
motion_correction_to_dff = channel.create()
mount_to_event_detection_jsons = channel.fromPath(params.ophys_mount_url + "/*.json", type: 'any')
dff_to_event_detection = channel.create()
mount_to_image_splitter = channel.fromPath(params.ophys_mount_url + "/", type: 'any')
classifier_to_processing_aggregator = channel.create()
event_detection_processing_aggregator = channel.create()
dff_to_processing_aggregator = channel.create()
extraction_to_processing_aggregator = channel.create()
decrosstalk_to_processing_aggregator = channel.create()
motion_correction_to_processing_aggregator = channel.create()
mount_to_processing_aggregator_jsons = channel.fromPath(params.ophys_mount_url + "/*.json", type: 'any')
classifier_to_nwb = channel.create()
motion_corrected_png_to_nwb = channel.create()
motion_corrected_h5_to_nwb = channel.create()
motion_corrected_webm_to_nwb = channel.create()
motion_corrected_transforms_to_nwb = channel.create()
ophys_mount_to_aind_ophys_nwb_31 = channel.fromPath(params.ophys_mount_url + "/", type: 'any')
oasis_event_detection_to_nwb = channel.create()
dff_to_nwb = channel.create()
extraction_h5_to_nwb = channel.create()
extraction_png_to_nwb = channel.create()
decrosstalk_to_nwb = channel.create()
subject_nwb_to_nwb = channel.create()
mount_to_subject_nwb = channel.fromPath(params.ophys_mount_url + "/", type: 'any')
motion_correction_to_movie_qc = channel.create()
classifier_to_qc_aggregator = channel.create()
motion_correction_to_qc_aggregator = channel.create()
extraction_to_classifier = channel.create()
mount_to_classifier_session = channel.fromPath(params.ophys_mount_url + "/session.json", type: 'any')

// capsule - aind-ophys-motion-correction
process capsule_aind_ophys_motion_correction_1 {
	tag 'capsule-7474660'
	container "$REGISTRY_HOST/published/91a8ed4d-3b9a-49c6-9283-3f16ea5482bf:v14"

	cpus 16
	memory '128 GB'

	publishDir "$RESULTS_PATH", saveAs: { filename -> new File(filename).getName() }

	input:
	path 'capsule/data/' from mount_to_motion_correction_jsons.collect()
	path 'capsule/data/' from mount_to_motion_correction_sync.collect()
	path 'capsule/data/' from image_splitter_to_motion_correction.flatten()

	output:
	path 'capsule/results/*'
	path 'capsule/results/V*' into motion_correction_to_decrosstalk_split
	path 'capsule/results/V*' into motion_correction_to_decrosstalk
	path 'capsule/results/*/motion_correction/*transform.csv' into motion_correction_to_dff
	path 'capsule/results/*/*/*data_process.json' into motion_correction_to_processing_aggregator
	path 'capsule/results/*/motion_correction/*.png' into motion_corrected_png_to_nwb
	path 'capsule/results/*/motion_correction/*.h5' into motion_corrected_h5_to_nwb
	path 'capsule/results/*/motion_correction/*.webm' into motion_corrected_webm_to_nwb
	path 'capsule/results/*/motion_correction/*.csv' into motion_corrected_transforms_to_nwb
	path 'capsule/results/V*' into motion_correction_to_movie_qc
	path 'capsule/results/*/motion_correction/*' into motion_correction_to_qc_aggregator

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=91a8ed4d-3b9a-49c6-9283-3f16ea5482bf
	export CO_CPUS=16
	export CO_MEMORY=137438953472

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	git clone --branch v14.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-7474660.git" capsule-repo
	mv capsule-repo/code capsule/code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run ${params.capsule_aind_ophys_motion_correction_1_args}

	echo "[${task.tag}] completed!"
	"""
}

// capsule - aind-ophys-decrosstalk-split-session-json
process capsule_aind_ophys_decrosstalk_split_session_json_2 {
	tag 'capsule-4425001'
	container "$REGISTRY_HOST/published/fc1b1e9a-fb4b-47e8-a223-b06d8eeb1462:v1"

	cpus 2
	memory '16 GB'

	publishDir "$RESULTS_PATH", saveAs: { filename -> new File(filename).getName() }

	input:
	path 'capsule/data/' from motion_correction_to_decrosstalk_split.collect()
	path 'capsule/data/' from mount_to_decrosstalk_split_session_json.collect()

	output:
	path 'capsule/results/*'
	path 'capsule/results/*' into decrosstalk_split_json_to_decrosstalk

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=fc1b1e9a-fb4b-47e8-a223-b06d8eeb1462
	export CO_CPUS=2
	export CO_MEMORY=17179869184

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	git clone --branch v1.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-4425001.git" capsule-repo
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
	tag 'capsule-1533578'
	container "$REGISTRY_HOST/published/1383b25a-ecd2-4c56-8b7f-cde811c0b053:v8"

	cpus 16
	memory '128 GB'

	publishDir "$RESULTS_PATH", saveAs: { filename -> new File(filename).getName() }

	input:
	path 'capsule/data/' from decrosstalk_split_json_to_decrosstalk.flatten()
	path 'capsule/data/' from image_splitter_to_decrosstalk.collect()
	path 'capsule/data/' from mount_to_decrosstalk_jsons.collect()
	path 'capsule/data/' from motion_correction_to_decrosstalk.collect()

	output:
	path 'capsule/results/*'
	path 'capsule/results/*' into decrosstalk_to_extraction
	path 'capsule/results/*/*/*data_process.json' into decrosstalk_to_processing_aggregator
	path 'capsule/results/*/decrosstalk/*.h5' into decrosstalk_to_nwb

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=1383b25a-ecd2-4c56-8b7f-cde811c0b053
	export CO_CPUS=16
	export CO_MEMORY=137438953472

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	git clone --branch v8.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-1533578.git" capsule-repo
	mv capsule-repo/code capsule/code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run

	echo "[${task.tag}] completed!"
	"""
}

// capsule - aind-ophys-extraction-suite2p
process capsule_aind_ophys_extraction_suite_2_p_4 {
	tag 'capsule-9911715'
	container "$REGISTRY_HOST/published/5e1d659c-e149-4a57-be83-12f5a448a0c9:v8"

	cpus 4
	memory '128 GB'

	publishDir "$RESULTS_PATH", saveAs: { filename -> new File(filename).getName() }

	input:
	path 'capsule/data/' from mount_to_extraction_jsons.collect()
	path 'capsule/data/' from decrosstalk_to_extraction.flatten()

	output:
	path 'capsule/results/*'
	path 'capsule/results/*' into extraction_to_dff
	path 'capsule/results/*/*/*data_process.json' into extraction_to_processing_aggregator
	path 'capsule/results/*/extraction/*.h5' into extraction_h5_to_nwb
	path 'capsule/results/*/extraction/*.png' into extraction_png_to_nwb
	path 'capsule/results/*' into extraction_to_classifier

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=5e1d659c-e149-4a57-be83-12f5a448a0c9
	export CO_CPUS=4
	export CO_MEMORY=137438953472

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	git clone --branch v8.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-9911715.git" capsule-repo
	mv capsule-repo/code capsule/code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run ${params.capsule_aind_ophys_extraction_suite_2_p_4_args}

	echo "[${task.tag}] completed!"
	"""
}

// capsule - aind-ophys-dff
process capsule_aind_ophys_dff_5 {
	tag 'capsule-6574773'
	container "$REGISTRY_HOST/published/85987e27-601c-4863-811b-71e5b4bdea37:v4"

	cpus 4
	memory '32 GB'

	publishDir "$RESULTS_PATH", saveAs: { filename -> new File(filename).getName() }

	input:
	path 'capsule/data/' from mount_to_dff_jsons.collect()
	path 'capsule/data/' from extraction_to_dff
	path 'capsule/data/' from motion_correction_to_dff.collect()

	output:
	path 'capsule/results/*'
	path 'capsule/results/*' into dff_to_event_detection
	path 'capsule/results/*/*/*data_process.json' into dff_to_processing_aggregator
	path 'capsule/results/*/dff/*.h5' into dff_to_nwb

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=85987e27-601c-4863-811b-71e5b4bdea37
	export CO_CPUS=4
	export CO_MEMORY=34359738368

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	git clone --branch v4.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-6574773.git" capsule-repo
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
	tag 'capsule-8957649'
	container "$REGISTRY_HOST/published/c6394aab-0db7-47b2-90ba-864866d6755e:v5"

	cpus 4
	memory '32 GB'

	publishDir "$RESULTS_PATH", saveAs: { filename -> new File(filename).getName() }

	input:
	path 'capsule/data/' from mount_to_event_detection_jsons.collect()
	path 'capsule/data/' from dff_to_event_detection

	output:
	path 'capsule/results/*'
	path 'capsule/results/*/*/*data_process.json' into event_detection_processing_aggregator
	path 'capsule/results/*/events/*.h5' into oasis_event_detection_to_nwb

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=c6394aab-0db7-47b2-90ba-864866d6755e
	export CO_CPUS=4
	export CO_MEMORY=34359738368

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	git clone --branch v5.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-8957649.git" capsule-repo
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
	tag 'capsule-4287852'
	container "$REGISTRY_HOST/published/74cf5765-d490-4ff8-accc-8cca3cbd05ae:v3"

	cpus 16
	memory '128 GB'

	input:
	path 'capsule/data' from mount_to_image_splitter.collect()

	output:
	path 'capsule/results/*_[0-9]' into image_splitter_to_motion_correction
	path 'capsule/results/*/V*_[0-9].h5' into image_splitter_to_decrosstalk

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=74cf5765-d490-4ff8-accc-8cca3cbd05ae
	export CO_CPUS=16
	export CO_MEMORY=137438953472

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	git clone --branch v3.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-4287852.git" capsule-repo
	mv capsule-repo/code capsule/code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run

	echo "[${task.tag}] completed!"
	"""
}

// capsule - aind-pipeline-processing-metadata-aggregator
process capsule_aind_pipeline_processing_metadata_aggregator_11 {
	tag 'capsule-8250608'
	container "$REGISTRY_HOST/published/d51df783-d892-4304-a129-238a9baea72a:v4"

	cpus 4
	memory '32 GB'

	publishDir "$RESULTS_PATH", saveAs: { filename -> new File(filename).getName() }

	input:
	path 'capsule/data/' from classifier_to_processing_aggregator.collect()
	path 'capsule/data/' from event_detection_processing_aggregator.collect()
	path 'capsule/data/' from dff_to_processing_aggregator.collect()
	path 'capsule/data/' from extraction_to_processing_aggregator.collect()
	path 'capsule/data/' from decrosstalk_to_processing_aggregator.collect()
	path 'capsule/data/' from motion_correction_to_processing_aggregator.collect()
	path 'capsule/data/' from mount_to_processing_aggregator_jsons.collect()

	output:
	path 'capsule/results/*'

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=d51df783-d892-4304-a129-238a9baea72a
	export CO_CPUS=4
	export CO_MEMORY=34359738368

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	git clone --branch v4.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-8250608.git" capsule-repo
	mv capsule-repo/code capsule/code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run --processor_full_name "Arielle Leon" --copy-ancillary-files True --derived-data-description True

	echo "[${task.tag}] completed!"
	"""
}

// capsule - aind-ophys-nwb
process capsule_aind_ophys_nwb_12 {
	tag 'capsule-9383700'
	container "$REGISTRY_HOST/published/8c436e95-8607-4752-8e9f-2b62024f9326:v12"

	cpus 1
	memory '8 GB'

	publishDir "$RESULTS_PATH", saveAs: { filename -> new File(filename).getName() }

	input:
	path 'capsule/data/processed/' from classifier_to_nwb.collect()
	path 'capsule/data/processed/' from motion_corrected_png_to_nwb.collect()
	path 'capsule/data/processed/' from motion_corrected_h5_to_nwb.collect()
	path 'capsule/data/processed/' from motion_corrected_webm_to_nwb.collect()
	path 'capsule/data/processed/' from motion_corrected_transforms_to_nwb.collect()
	path 'capsule/data/multiplane-ophys_raw' from ophys_mount_to_aind_ophys_nwb_31.collect()
	path 'capsule/data/processed/' from oasis_event_detection_to_nwb.collect()
	path 'capsule/data/processed/' from dff_to_nwb.collect()
	path 'capsule/data/processed/' from extraction_h5_to_nwb.collect()
	path 'capsule/data/' from extraction_png_to_nwb.collect()
	path 'capsule/data/processed/' from decrosstalk_to_nwb.collect()
	path 'capsule/data/nwb/' from subject_nwb_to_nwb.collect()

	output:
	path 'capsule/results/*'

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=8c436e95-8607-4752-8e9f-2b62024f9326
	export CO_CPUS=1
	export CO_MEMORY=8589934592

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	ln -s "/tmp/data/schemas" "capsule/data/schemas" # id: fb4b5cef-4505-4145-b8bd-e41d6863d7a9

	echo "[${task.tag}] cloning git repo..."
	git clone --branch v12.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-9383700.git" capsule-repo
	mv capsule-repo/code capsule/code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run

	echo "[${task.tag}] completed!"
	"""
}

// capsule - NWB-Packaging-Subject-Capsule
process capsule_nwb_packaging_subject_capsule_13 {
	tag 'capsule-8198603'
	container "$REGISTRY_HOST/published/bdc9f09f-0005-4d09-aaf9-7e82abd93f19:v2"

	cpus 1
	memory '8 GB'

	input:
	path 'capsule/data/ophys_session' from mount_to_subject_nwb.collect()

	output:
	path 'capsule/results/*' into subject_nwb_to_nwb

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=bdc9f09f-0005-4d09-aaf9-7e82abd93f19
	export CO_CPUS=1
	export CO_MEMORY=8589934592

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	git clone --branch v2.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-8198603.git" capsule-repo
	mv capsule-repo/code capsule/code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run ${params.capsule_nwb_packaging_subject_capsule_13_args}

	echo "[${task.tag}] completed!"
	"""
}

// capsule - aind-ophys-movie-qc
process capsule_aind_ophys_movie_qc_15 {
	tag 'capsule-0300037'
	container "$REGISTRY_HOST/published/f52d9390-8569-49bb-9562-2d624b18ee56:v5"

	cpus 16
	memory '128 GB'

	publishDir "$RESULTS_PATH", saveAs: { filename -> new File(filename).getName() }

	input:
	path 'capsule/data/' from motion_correction_to_movie_qc.flatten()

	output:
	path 'capsule/results/*'

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=f52d9390-8569-49bb-9562-2d624b18ee56
	export CO_CPUS=16
	export CO_MEMORY=137438953472

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	git clone --branch v5.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-0300037.git" capsule-repo
	mv capsule-repo/code capsule/code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run

	echo "[${task.tag}] completed!"
	"""
}

// capsule - aind-ophys-quality-control-aggregator
process capsule_aind_ophys_quality_control_aggregator_16 {
	tag 'capsule-4044810'
	container "$REGISTRY_HOST/published/4a698b5c-f5f6-4671-8234-dc728d049a68:v2"

	cpus 1
	memory '8 GB'

	publishDir "$RESULTS_PATH", saveAs: { filename -> new File(filename).getName() }

	input:
	path 'capsule/data/processed/' from classifier_to_qc_aggregator.collect()
	path 'capsule/data/' from motion_correction_to_qc_aggregator.collect()

	output:
	path 'capsule/results/*'

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=4a698b5c-f5f6-4671-8234-dc728d049a68
	export CO_CPUS=1
	export CO_MEMORY=8589934592

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	git clone --branch v2.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-4044810.git" capsule-repo
	mv capsule-repo/code capsule/code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run

	echo "[${task.tag}] completed!"
	"""
}

// capsule - aind-ophys-classifier
process capsule_aind_ophys_classifier_17 {
	tag 'capsule-0630574'
	container "$REGISTRY_HOST/published/3819d125-9f03-48f3-ba09-b44c84a7a2c7:v3"

	cpus 4
	memory '200 GB'
	accelerator 1
	label 'gpu'

	publishDir "$RESULTS_PATH", saveAs: { filename -> new File(filename).getName() }

	input:
	path 'capsule/data/' from extraction_to_classifier
	path 'capsule/data/' from mount_to_classifier_session.collect()

	output:
	path 'capsule/results/*/*/*data_process.json' into classifier_to_processing_aggregator
	path 'capsule/results/*/classification/*classification.h5' into classifier_to_nwb
	path 'capsule/results/*/classification/*classification.h5' into classifier_to_qc_aggregator
	path 'capsule/results/*'

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=3819d125-9f03-48f3-ba09-b44c84a7a2c7
	export CO_CPUS=4
	export CO_MEMORY=214748364800

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	ln -s "/tmp/data/2p_roi_classifier" "capsule/data/2p_roi_classifier" # id: 35d1284e-4dfa-4ac3-9ba8-5ea1ae2fdaeb

	echo "[${task.tag}] cloning git repo..."
	git clone --branch v3.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-0630574.git" capsule-repo
	mv capsule-repo/code capsule/code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run

	echo "[${task.tag}] completed!"
	"""
}

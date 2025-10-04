#!/usr/bin/env nextflow
// hash:sha256:3302dcba464bdc7139feb3fd0888cab9ddd842278d4cdcee91610ed28d598e85

nextflow.enable.dsl = 1

params.ophys_mount_url = 's3://aind-private-data-prod-o5171v/multiplane-ophys_784492_2025-06-04_14-42-32'

ophys_mount_to_aind_ophys_motion_correction_1 = channel.fromPath(params.ophys_mount_url + "/*json", type: 'any')
ophys_mount_to_aind_ophys_motion_correction_2 = channel.fromPath(params.ophys_mount_url + "/pophys", type: 'any')
ophys_mount_to_aind_ophys_motion_correction_3 = channel.fromPath(params.ophys_mount_url + "/*/*.h5", type: 'any')
capsule_copy_of_aind_pophys_converter_capsule_v_7_10_to_capsule_aind_ophys_motion_correction_1_4 = channel.create()
capsule_aind_ophys_motion_correction_1_to_capsule_jinhos_copy_of_aind_ophys_decrosstalk_split_session_json_2_5 = channel.create()
ophys_mount_to_jinho_s_copy_of_aind_ophys_decrosstalk_split_session_json_6 = channel.fromPath(params.ophys_mount_url + "/session.json", type: 'any')
ophys_mount_to_aind_ophys_decrosstalk_roi_images_7 = channel.fromPath(params.ophys_mount_url + "/*.json", type: 'any')
ophys_mount_to_aind_ophys_decrosstalk_roi_images_8 = channel.fromPath(params.ophys_mount_url + "/pophys", type: 'any')
capsule_copy_of_aind_pophys_converter_capsule_v_7_10_to_capsule_aind_ophys_decrosstalk_roi_images_3_9 = channel.create()
capsule_jinhos_copy_of_aind_ophys_decrosstalk_split_session_json_2_to_capsule_aind_ophys_decrosstalk_roi_images_3_10 = channel.create()
capsule_aind_ophys_motion_correction_1_to_capsule_aind_ophys_decrosstalk_roi_images_3_11 = channel.create()
ophys_mount_to_aind_ophys_extraction_12 = channel.fromPath(params.ophys_mount_url + "/*.json", type: 'any')
capsule_aind_ophys_decrosstalk_roi_images_3_to_capsule_aind_ophys_extraction_suite_2_p_4_13 = channel.create()
ophys_mount_to_aind_ophys_dff_14 = channel.fromPath(params.ophys_mount_url + "/*.json", type: 'any')
capsule_aind_ophys_extraction_suite_2_p_4_to_capsule_aind_ophys_dff_5_15 = channel.create()
capsule_aind_ophys_motion_correction_1_to_capsule_aind_ophys_dff_5_16 = channel.create()
ophys_mount_to_aind_ophys_oasis_event_detection_17 = channel.fromPath(params.ophys_mount_url + "/*.json", type: 'any')
capsule_aind_ophys_dff_5_to_capsule_aind_ophys_oasis_event_detection_9_18 = channel.create()
ophys_mount_to_copy_of_aind_pophys_converter_capsule_v7_19 = channel.fromPath(params.ophys_mount_url + "/", type: 'any')
capsule_aind_ophys_classifier_17_to_capsule_aind_pipeline_processing_metadata_aggregator_11_20 = channel.create()
capsule_aind_ophys_oasis_event_detection_9_to_capsule_aind_pipeline_processing_metadata_aggregator_11_21 = channel.create()
capsule_aind_ophys_dff_5_to_capsule_aind_pipeline_processing_metadata_aggregator_11_22 = channel.create()
capsule_aind_ophys_extraction_suite_2_p_4_to_capsule_aind_pipeline_processing_metadata_aggregator_11_23 = channel.create()
capsule_aind_ophys_decrosstalk_roi_images_3_to_capsule_aind_pipeline_processing_metadata_aggregator_11_24 = channel.create()
capsule_aind_ophys_motion_correction_1_to_capsule_aind_pipeline_processing_metadata_aggregator_11_25 = channel.create()
ophys_mount_to_aind_pipeline_processing_metadata_aggregator_26 = channel.fromPath(params.ophys_mount_url + "/*.json", type: 'any')
ophys_mount_to_jinho_s_copy_of_aind_ophys_nwb_27 = channel.fromPath(params.ophys_mount_url + "/", type: 'any')
capsule_aind_ophys_classifier_17_to_capsule_jinhos_copy_of_aind_ophys_nwb_12_28 = channel.create()
capsule_aind_ophys_motion_correction_1_to_capsule_jinhos_copy_of_aind_ophys_nwb_12_29 = channel.create()
capsule_aind_ophys_motion_correction_1_to_capsule_jinhos_copy_of_aind_ophys_nwb_12_30 = channel.create()
capsule_aind_ophys_motion_correction_1_to_capsule_jinhos_copy_of_aind_ophys_nwb_12_31 = channel.create()
capsule_aind_ophys_motion_correction_1_to_capsule_jinhos_copy_of_aind_ophys_nwb_12_32 = channel.create()
capsule_aind_ophys_oasis_event_detection_9_to_capsule_jinhos_copy_of_aind_ophys_nwb_12_33 = channel.create()
capsule_aind_ophys_dff_5_to_capsule_jinhos_copy_of_aind_ophys_nwb_12_34 = channel.create()
capsule_aind_ophys_extraction_suite_2_p_4_to_capsule_jinhos_copy_of_aind_ophys_nwb_12_35 = channel.create()
capsule_aind_ophys_extraction_suite_2_p_4_to_capsule_jinhos_copy_of_aind_ophys_nwb_12_36 = channel.create()
capsule_aind_ophys_decrosstalk_roi_images_3_to_capsule_jinhos_copy_of_aind_ophys_nwb_12_37 = channel.create()
capsule_nwb_packaging_subject_capsule_13_to_capsule_jinhos_copy_of_aind_ophys_nwb_12_38 = channel.create()
ophys_mount_to_nwb_packaging_subject_39 = channel.fromPath(params.ophys_mount_url + "/", type: 'any')
ophys_mount_to_aind_ophys_movie_qc_40 = channel.fromPath(params.ophys_mount_url + "/", type: 'any')
capsule_copy_of_aind_pophys_converter_capsule_v_7_10_to_capsule_aind_ophys_movie_qc_15_41 = channel.create()
capsule_aind_ophys_motion_correction_1_to_capsule_aind_ophys_movie_qc_15_42 = channel.create()
ophys_mount_to_jinho_s_copy_of_aind_ophys_quality_control_aggregator_43 = channel.fromPath(params.ophys_mount_url + "/*.json", type: 'any')
capsule_aind_ophys_oasis_event_detection_9_to_capsule_jinhos_copy_of_aind_ophys_quality_control_aggregator_16_44 = channel.create()
capsule_aind_ophys_oasis_event_detection_9_to_capsule_jinhos_copy_of_aind_ophys_quality_control_aggregator_16_45 = channel.create()
capsule_aind_ophys_movie_qc_15_to_capsule_jinhos_copy_of_aind_ophys_quality_control_aggregator_16_46 = channel.create()
capsule_aind_ophys_movie_qc_15_to_capsule_jinhos_copy_of_aind_ophys_quality_control_aggregator_16_47 = channel.create()
capsule_aind_ophys_classifier_17_to_capsule_jinhos_copy_of_aind_ophys_quality_control_aggregator_16_48 = channel.create()
capsule_aind_ophys_classifier_17_to_capsule_jinhos_copy_of_aind_ophys_quality_control_aggregator_16_49 = channel.create()
capsule_aind_ophys_decrosstalk_roi_images_3_to_capsule_jinhos_copy_of_aind_ophys_quality_control_aggregator_16_50 = channel.create()
capsule_aind_ophys_extraction_suite_2_p_4_to_capsule_jinhos_copy_of_aind_ophys_quality_control_aggregator_16_51 = channel.create()
capsule_aind_ophys_motion_correction_1_to_capsule_jinhos_copy_of_aind_ophys_quality_control_aggregator_16_52 = channel.create()
capsule_aind_ophys_extraction_suite_2_p_4_to_capsule_aind_ophys_classifier_17_53 = channel.create()
ophys_mount_to_aind_ophys_classifier_54 = channel.fromPath(params.ophys_mount_url + "/session.json", type: 'any')

// capsule - aind-ophys-motion-correction
process capsule_aind_ophys_motion_correction_1 {
	tag 'capsule-7474660'
	container "$REGISTRY_HOST/published/91a8ed4d-3b9a-49c6-9283-3f16ea5482bf:v19"

	cpus 16
	memory '120 GB'

	publishDir "$RESULTS_PATH", saveAs: { filename -> new File(filename).getName() }

	input:
	path 'capsule/data/' from ophys_mount_to_aind_ophys_motion_correction_1.collect()
	path 'capsule/data/' from ophys_mount_to_aind_ophys_motion_correction_2.collect()
	path 'capsule/data/' from ophys_mount_to_aind_ophys_motion_correction_3.collect()
	path 'capsule/data/' from capsule_copy_of_aind_pophys_converter_capsule_v_7_10_to_capsule_aind_ophys_motion_correction_1_4.flatten()

	output:
	path 'capsule/results/*'
	path 'capsule/results/V*' into capsule_aind_ophys_motion_correction_1_to_capsule_jinhos_copy_of_aind_ophys_decrosstalk_split_session_json_2_5
	path 'capsule/results/V*' into capsule_aind_ophys_motion_correction_1_to_capsule_aind_ophys_decrosstalk_roi_images_3_11
	path 'capsule/results/*/motion_correction/*transform.csv' into capsule_aind_ophys_motion_correction_1_to_capsule_aind_ophys_dff_5_16
	path 'capsule/results/*/*/*data_process.json' into capsule_aind_ophys_motion_correction_1_to_capsule_aind_pipeline_processing_metadata_aggregator_11_25
	path 'capsule/results/*/motion_correction/*.png' into capsule_aind_ophys_motion_correction_1_to_capsule_jinhos_copy_of_aind_ophys_nwb_12_29
	path 'capsule/results/*/motion_correction/*.h5' into capsule_aind_ophys_motion_correction_1_to_capsule_jinhos_copy_of_aind_ophys_nwb_12_30
	path 'capsule/results/*/motion_correction/*.webm' into capsule_aind_ophys_motion_correction_1_to_capsule_jinhos_copy_of_aind_ophys_nwb_12_31
	path 'capsule/results/*/motion_correction/*.csv' into capsule_aind_ophys_motion_correction_1_to_capsule_jinhos_copy_of_aind_ophys_nwb_12_32
	path 'capsule/results/V*' into capsule_aind_ophys_motion_correction_1_to_capsule_aind_ophys_movie_qc_15_42
	path 'capsule/results/*/motion_correction/*' into capsule_aind_ophys_motion_correction_1_to_capsule_jinhos_copy_of_aind_ophys_quality_control_aggregator_16_52

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=91a8ed4d-3b9a-49c6-9283-3f16ea5482bf
	export CO_CPUS=16
	export CO_MEMORY=128849018880

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	if [[ "\$(printf '%s\n' "2.20.0" "\$(git version | awk '{print \$3}')" | sort -V | head -n1)" = "2.20.0" ]]; then
		git clone --filter=tree:0 --branch v19.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-7474660.git" capsule-repo
	else
		git clone --branch v19.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-7474660.git" capsule-repo
	fi
	mv capsule-repo/code capsule/code && ln -s \$PWD/capsule/code /code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run ${params.capsule_aind_ophys_motion_correction_1_args}

	echo "[${task.tag}] completed!"
	"""
}

// capsule - Jinho's Copy of aind-ophys-decrosstalk-split-session-json
process capsule_jinhos_copy_of_aind_ophys_decrosstalk_split_session_json_2 {
	tag 'capsule-9107781'
	container "$REGISTRY_HOST/capsule/f62f74da-6f46-4c62-bae7-77aac2192326"

	cpus 1
	memory '7.5 GB'

	publishDir "$RESULTS_PATH", saveAs: { filename -> new File(filename).getName() }

	input:
	path 'capsule/data/' from capsule_aind_ophys_motion_correction_1_to_capsule_jinhos_copy_of_aind_ophys_decrosstalk_split_session_json_2_5.collect()
	path 'capsule/data/' from ophys_mount_to_jinho_s_copy_of_aind_ophys_decrosstalk_split_session_json_6.collect()

	output:
	path 'capsule/results/*'
	path 'capsule/results/*' into capsule_jinhos_copy_of_aind_ophys_decrosstalk_split_session_json_2_to_capsule_aind_ophys_decrosstalk_roi_images_3_10

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=f62f74da-6f46-4c62-bae7-77aac2192326
	export CO_CPUS=1
	export CO_MEMORY=8053063680

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	if [[ "\$(printf '%s\n' "2.20.0" "\$(git version | awk '{print \$3}')" | sort -V | head -n1)" = "2.20.0" ]]; then
		git clone --filter=tree:0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-9107781.git" capsule-repo
	else
		git clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-9107781.git" capsule-repo
	fi
	mv capsule-repo/code capsule/code && ln -s \$PWD/capsule/code /code
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
	container "$REGISTRY_HOST/published/1383b25a-ecd2-4c56-8b7f-cde811c0b053:v12"

	cpus 16
	memory '120 GB'

	publishDir "$RESULTS_PATH", saveAs: { filename -> new File(filename).getName() }

	input:
	path 'capsule/data/' from ophys_mount_to_aind_ophys_decrosstalk_roi_images_7.collect()
	path 'capsule/data/' from ophys_mount_to_aind_ophys_decrosstalk_roi_images_8.collect()
	path 'capsule/data/' from capsule_copy_of_aind_pophys_converter_capsule_v_7_10_to_capsule_aind_ophys_decrosstalk_roi_images_3_9.collect()
	path 'capsule/data/' from capsule_jinhos_copy_of_aind_ophys_decrosstalk_split_session_json_2_to_capsule_aind_ophys_decrosstalk_roi_images_3_10.flatten()
	path 'capsule/data/' from capsule_aind_ophys_motion_correction_1_to_capsule_aind_ophys_decrosstalk_roi_images_3_11.collect()

	output:
	path 'capsule/results/*'
	path 'capsule/results/*' into capsule_aind_ophys_decrosstalk_roi_images_3_to_capsule_aind_ophys_extraction_suite_2_p_4_13
	path 'capsule/results/*/*/*data_process.json' into capsule_aind_ophys_decrosstalk_roi_images_3_to_capsule_aind_pipeline_processing_metadata_aggregator_11_24
	path 'capsule/results/*/decrosstalk/*.h5' into capsule_aind_ophys_decrosstalk_roi_images_3_to_capsule_jinhos_copy_of_aind_ophys_nwb_12_37
	path 'capsule/results/*/*/*.json' into capsule_aind_ophys_decrosstalk_roi_images_3_to_capsule_jinhos_copy_of_aind_ophys_quality_control_aggregator_16_50

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=1383b25a-ecd2-4c56-8b7f-cde811c0b053
	export CO_CPUS=16
	export CO_MEMORY=128849018880

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	if [[ "\$(printf '%s\n' "2.20.0" "\$(git version | awk '{print \$3}')" | sort -V | head -n1)" = "2.20.0" ]]; then
		git clone --filter=tree:0 --branch v12.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-1533578.git" capsule-repo
	else
		git clone --branch v12.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-1533578.git" capsule-repo
	fi
	mv capsule-repo/code capsule/code && ln -s \$PWD/capsule/code /code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run ${params.capsule_aind_ophys_decrosstalk_roi_images_3_args}

	echo "[${task.tag}] completed!"
	"""
}

// capsule - aind-ophys-extraction
process capsule_aind_ophys_extraction_suite_2_p_4 {
	tag 'capsule-9911715'
	container "$REGISTRY_HOST/published/5e1d659c-e149-4a57-be83-12f5a448a0c9:v13"

	cpus 1
	memory '7.5 GB'

	publishDir "$RESULTS_PATH", saveAs: { filename -> new File(filename).getName() }

	input:
	path 'capsule/data/' from ophys_mount_to_aind_ophys_extraction_12.collect()
	path 'capsule/data/' from capsule_aind_ophys_decrosstalk_roi_images_3_to_capsule_aind_ophys_extraction_suite_2_p_4_13.flatten()

	output:
	path 'capsule/results/*'
	path 'capsule/results/*' into capsule_aind_ophys_extraction_suite_2_p_4_to_capsule_aind_ophys_dff_5_15
	path 'capsule/results/*/*/*data_process.json' into capsule_aind_ophys_extraction_suite_2_p_4_to_capsule_aind_pipeline_processing_metadata_aggregator_11_23
	path 'capsule/results/*/extraction/*.h5' into capsule_aind_ophys_extraction_suite_2_p_4_to_capsule_jinhos_copy_of_aind_ophys_nwb_12_35
	path 'capsule/results/*/extraction/*.png' into capsule_aind_ophys_extraction_suite_2_p_4_to_capsule_jinhos_copy_of_aind_ophys_nwb_12_36
	path 'capsule/results/*/*/*.json' into capsule_aind_ophys_extraction_suite_2_p_4_to_capsule_jinhos_copy_of_aind_ophys_quality_control_aggregator_16_51
	path 'capsule/results/*' into capsule_aind_ophys_extraction_suite_2_p_4_to_capsule_aind_ophys_classifier_17_53

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=5e1d659c-e149-4a57-be83-12f5a448a0c9
	export CO_CPUS=1
	export CO_MEMORY=8053063680

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	if [[ "\$(printf '%s\n' "2.20.0" "\$(git version | awk '{print \$3}')" | sort -V | head -n1)" = "2.20.0" ]]; then
		git clone --filter=tree:0 --branch v13.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-9911715.git" capsule-repo
	else
		git clone --branch v13.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-9911715.git" capsule-repo
	fi
	mv capsule-repo/code capsule/code && ln -s \$PWD/capsule/code /code
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
	container "$REGISTRY_HOST/published/85987e27-601c-4863-811b-71e5b4bdea37:v5"

	cpus 4
	memory '30 GB'

	publishDir "$RESULTS_PATH", saveAs: { filename -> new File(filename).getName() }

	input:
	path 'capsule/data/' from ophys_mount_to_aind_ophys_dff_14.collect()
	path 'capsule/data/' from capsule_aind_ophys_extraction_suite_2_p_4_to_capsule_aind_ophys_dff_5_15
	path 'capsule/data/' from capsule_aind_ophys_motion_correction_1_to_capsule_aind_ophys_dff_5_16.collect()

	output:
	path 'capsule/results/*'
	path 'capsule/results/*' into capsule_aind_ophys_dff_5_to_capsule_aind_ophys_oasis_event_detection_9_18
	path 'capsule/results/*/*/*data_process.json' into capsule_aind_ophys_dff_5_to_capsule_aind_pipeline_processing_metadata_aggregator_11_22
	path 'capsule/results/*/dff/*.h5' into capsule_aind_ophys_dff_5_to_capsule_jinhos_copy_of_aind_ophys_nwb_12_34

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=85987e27-601c-4863-811b-71e5b4bdea37
	export CO_CPUS=4
	export CO_MEMORY=32212254720

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	if [[ "\$(printf '%s\n' "2.20.0" "\$(git version | awk '{print \$3}')" | sort -V | head -n1)" = "2.20.0" ]]; then
		git clone --filter=tree:0 --branch v5.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-6574773.git" capsule-repo
	else
		git clone --branch v5.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-6574773.git" capsule-repo
	fi
	mv capsule-repo/code capsule/code && ln -s \$PWD/capsule/code /code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run ${params.capsule_aind_ophys_dff_5_args}

	echo "[${task.tag}] completed!"
	"""
}

// capsule - aind-ophys-oasis-event-detection
process capsule_aind_ophys_oasis_event_detection_9 {
	tag 'capsule-8957649'
	container "$REGISTRY_HOST/published/c6394aab-0db7-47b2-90ba-864866d6755e:v10"

	cpus 1
	memory '7.5 GB'

	publishDir "$RESULTS_PATH", saveAs: { filename -> new File(filename).getName() }

	input:
	path 'capsule/data/' from ophys_mount_to_aind_ophys_oasis_event_detection_17.collect()
	path 'capsule/data/' from capsule_aind_ophys_dff_5_to_capsule_aind_ophys_oasis_event_detection_9_18

	output:
	path 'capsule/results/*'
	path 'capsule/results/*/*/*data_process.json' into capsule_aind_ophys_oasis_event_detection_9_to_capsule_aind_pipeline_processing_metadata_aggregator_11_21
	path 'capsule/results/*/events/*.h5' into capsule_aind_ophys_oasis_event_detection_9_to_capsule_jinhos_copy_of_aind_ophys_nwb_12_33
	path 'capsule/results/*/events/*.json' into capsule_aind_ophys_oasis_event_detection_9_to_capsule_jinhos_copy_of_aind_ophys_quality_control_aggregator_16_44
	path 'capsule/results/*/*/plots/*' into capsule_aind_ophys_oasis_event_detection_9_to_capsule_jinhos_copy_of_aind_ophys_quality_control_aggregator_16_45

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=c6394aab-0db7-47b2-90ba-864866d6755e
	export CO_CPUS=1
	export CO_MEMORY=8053063680

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	if [[ "\$(printf '%s\n' "2.20.0" "\$(git version | awk '{print \$3}')" | sort -V | head -n1)" = "2.20.0" ]]; then
		git clone --filter=tree:0 --branch v10.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-8957649.git" capsule-repo
	else
		git clone --branch v10.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-8957649.git" capsule-repo
	fi
	mv capsule-repo/code capsule/code && ln -s \$PWD/capsule/code /code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run

	echo "[${task.tag}] completed!"
	"""
}

// capsule - Copy of aind-pophys-converter-capsule v7
process capsule_copy_of_aind_pophys_converter_capsule_v_7_10 {
	tag 'capsule-0757717'
	container "$REGISTRY_HOST/capsule/635d1f55-3d01-4962-b641-89eb6d0c852d:e77b47a7a4a2a3dbcd0a61384b91c807"

	cpus 16
	memory '120 GB'

	input:
	path 'capsule/data' from ophys_mount_to_copy_of_aind_pophys_converter_capsule_v7_19.collect()

	output:
	path 'capsule/results/*_[0-9]' into capsule_copy_of_aind_pophys_converter_capsule_v_7_10_to_capsule_aind_ophys_motion_correction_1_4
	path 'capsule/results/*/*' into capsule_copy_of_aind_pophys_converter_capsule_v_7_10_to_capsule_aind_ophys_decrosstalk_roi_images_3_9
	path 'capsule/results/*' into capsule_copy_of_aind_pophys_converter_capsule_v_7_10_to_capsule_aind_ophys_movie_qc_15_41

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=635d1f55-3d01-4962-b641-89eb6d0c852d
	export CO_CPUS=16
	export CO_MEMORY=128849018880

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	if [[ "\$(printf '%s\n' "2.20.0" "\$(git version | awk '{print \$3}')" | sort -V | head -n1)" = "2.20.0" ]]; then
		git clone --filter=tree:0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-0757717.git" capsule-repo
	else
		git clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-0757717.git" capsule-repo
	fi
	git -C capsule-repo checkout 0e6c5ff3bd5a90f1fb1a2e3c56bd6dce5a686d78 --quiet
	mv capsule-repo/code capsule/code && ln -s \$PWD/capsule/code /code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run ${params.capsule_copy_of_aind_pophys_converter_capsule_v_7_10_args}

	echo "[${task.tag}] completed!"
	"""
}

// capsule - aind-pipeline-processing-metadata-aggregator
process capsule_aind_pipeline_processing_metadata_aggregator_11 {
	tag 'capsule-8324994'
	container "$REGISTRY_HOST/published/22261566-0b4f-42aa-bcaa-58efa55bf653:v2"

	cpus 1
	memory '7.5 GB'

	publishDir "$RESULTS_PATH", saveAs: { filename -> new File(filename).getName() }

	input:
	path 'capsule/data/' from capsule_aind_ophys_classifier_17_to_capsule_aind_pipeline_processing_metadata_aggregator_11_20.collect()
	path 'capsule/data/' from capsule_aind_ophys_oasis_event_detection_9_to_capsule_aind_pipeline_processing_metadata_aggregator_11_21.collect()
	path 'capsule/data/' from capsule_aind_ophys_dff_5_to_capsule_aind_pipeline_processing_metadata_aggregator_11_22.collect()
	path 'capsule/data/' from capsule_aind_ophys_extraction_suite_2_p_4_to_capsule_aind_pipeline_processing_metadata_aggregator_11_23.collect()
	path 'capsule/data/' from capsule_aind_ophys_decrosstalk_roi_images_3_to_capsule_aind_pipeline_processing_metadata_aggregator_11_24.collect()
	path 'capsule/data/' from capsule_aind_ophys_motion_correction_1_to_capsule_aind_pipeline_processing_metadata_aggregator_11_25.collect()
	path 'capsule/data/' from ophys_mount_to_aind_pipeline_processing_metadata_aggregator_26.collect()

	output:
	path 'capsule/results/*'

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=22261566-0b4f-42aa-bcaa-58efa55bf653
	export CO_CPUS=1
	export CO_MEMORY=8053063680

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	if [[ "\$(printf '%s\n' "2.20.0" "\$(git version | awk '{print \$3}')" | sort -V | head -n1)" = "2.20.0" ]]; then
		git clone --filter=tree:0 --branch v2.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-8324994.git" capsule-repo
	else
		git clone --branch v2.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-8324994.git" capsule-repo
	fi
	mv capsule-repo/code capsule/code && ln -s \$PWD/capsule/code /code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run ${params.capsule_aind_pipeline_processing_metadata_aggregator_11_args}

	echo "[${task.tag}] completed!"
	"""
}

// capsule - Jinho's Copy of aind-ophys-nwb
process capsule_jinhos_copy_of_aind_ophys_nwb_12 {
	tag 'capsule-9882614'
	container "$REGISTRY_HOST/capsule/eca34d68-06e7-4d4b-aca4-2d92fbcad74b"

	cpus 1
	memory '7.5 GB'

	publishDir "$RESULTS_PATH", saveAs: { filename -> new File(filename).getName() }

	input:
	path 'capsule/data/raw' from ophys_mount_to_jinho_s_copy_of_aind_ophys_nwb_27.collect()
	path 'capsule/data/processed/' from capsule_aind_ophys_classifier_17_to_capsule_jinhos_copy_of_aind_ophys_nwb_12_28.collect()
	path 'capsule/data/processed/' from capsule_aind_ophys_motion_correction_1_to_capsule_jinhos_copy_of_aind_ophys_nwb_12_29.collect()
	path 'capsule/data/processed/' from capsule_aind_ophys_motion_correction_1_to_capsule_jinhos_copy_of_aind_ophys_nwb_12_30.collect()
	path 'capsule/data/processed/' from capsule_aind_ophys_motion_correction_1_to_capsule_jinhos_copy_of_aind_ophys_nwb_12_31.collect()
	path 'capsule/data/processed/' from capsule_aind_ophys_motion_correction_1_to_capsule_jinhos_copy_of_aind_ophys_nwb_12_32.collect()
	path 'capsule/data/processed/' from capsule_aind_ophys_oasis_event_detection_9_to_capsule_jinhos_copy_of_aind_ophys_nwb_12_33.collect()
	path 'capsule/data/processed/' from capsule_aind_ophys_dff_5_to_capsule_jinhos_copy_of_aind_ophys_nwb_12_34.collect()
	path 'capsule/data/processed/' from capsule_aind_ophys_extraction_suite_2_p_4_to_capsule_jinhos_copy_of_aind_ophys_nwb_12_35.collect()
	path 'capsule/data/' from capsule_aind_ophys_extraction_suite_2_p_4_to_capsule_jinhos_copy_of_aind_ophys_nwb_12_36.collect()
	path 'capsule/data/processed/' from capsule_aind_ophys_decrosstalk_roi_images_3_to_capsule_jinhos_copy_of_aind_ophys_nwb_12_37.collect()
	path 'capsule/data/nwb/' from capsule_nwb_packaging_subject_capsule_13_to_capsule_jinhos_copy_of_aind_ophys_nwb_12_38.collect()

	output:
	path 'capsule/results/*'

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=eca34d68-06e7-4d4b-aca4-2d92fbcad74b
	export CO_CPUS=1
	export CO_MEMORY=8053063680

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	ln -s "/tmp/data/schemas" "capsule/data/schemas" # id: fb4b5cef-4505-4145-b8bd-e41d6863d7a9

	echo "[${task.tag}] cloning git repo..."
	if [[ "\$(printf '%s\n' "2.20.0" "\$(git version | awk '{print \$3}')" | sort -V | head -n1)" = "2.20.0" ]]; then
		git clone --filter=tree:0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-9882614.git" capsule-repo
	else
		git clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-9882614.git" capsule-repo
	fi
	mv capsule-repo/code capsule/code && ln -s \$PWD/capsule/code /code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run

	echo "[${task.tag}] completed!"
	"""
}

// capsule - NWB Packaging Subject
process capsule_nwb_packaging_subject_capsule_13 {
	tag 'capsule-8198603'
	container "$REGISTRY_HOST/published/bdc9f09f-0005-4d09-aaf9-7e82abd93f19:v3"

	cpus 1
	memory '7.5 GB'

	input:
	path 'capsule/data/ophys_session' from ophys_mount_to_nwb_packaging_subject_39.collect()

	output:
	path 'capsule/results/*' into capsule_nwb_packaging_subject_capsule_13_to_capsule_jinhos_copy_of_aind_ophys_nwb_12_38

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=bdc9f09f-0005-4d09-aaf9-7e82abd93f19
	export CO_CPUS=1
	export CO_MEMORY=8053063680

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	if [[ "\$(printf '%s\n' "2.20.0" "\$(git version | awk '{print \$3}')" | sort -V | head -n1)" = "2.20.0" ]]; then
		git clone --filter=tree:0 --branch v3.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-8198603.git" capsule-repo
	else
		git clone --branch v3.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-8198603.git" capsule-repo
	fi
	mv capsule-repo/code capsule/code && ln -s \$PWD/capsule/code /code
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
	tag 'capsule-1646132'
	container "$REGISTRY_HOST/capsule/ae1f5b8c-4a2d-4771-bbb2-212815c180ce:c588d43760f7993054eb672e255481a3"

	cpus 16
	memory '120 GB'

	publishDir "$RESULTS_PATH", saveAs: { filename -> new File(filename).getName() }

	input:
	path 'capsule/data/raw' from ophys_mount_to_aind_ophys_movie_qc_40.collect()
	path 'capsule/data/zstacks/' from capsule_copy_of_aind_pophys_converter_capsule_v_7_10_to_capsule_aind_ophys_movie_qc_15_41.collect()
	path 'capsule/data/' from capsule_aind_ophys_motion_correction_1_to_capsule_aind_ophys_movie_qc_15_42.flatten()

	output:
	path 'capsule/results/*'
	path 'capsule/results/*/*/*.json' into capsule_aind_ophys_movie_qc_15_to_capsule_jinhos_copy_of_aind_ophys_quality_control_aggregator_16_46
	path 'capsule/results/*/*/*.png' into capsule_aind_ophys_movie_qc_15_to_capsule_jinhos_copy_of_aind_ophys_quality_control_aggregator_16_47

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=ae1f5b8c-4a2d-4771-bbb2-212815c180ce
	export CO_CPUS=16
	export CO_MEMORY=128849018880

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	if [[ "\$(printf '%s\n' "2.20.0" "\$(git version | awk '{print \$3}')" | sort -V | head -n1)" = "2.20.0" ]]; then
		git clone --filter=tree:0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-1646132.git" capsule-repo
	else
		git clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-1646132.git" capsule-repo
	fi
	git -C capsule-repo checkout 7bcf8897b5096f81081ddc6a297a285e67f7281b --quiet
	mv capsule-repo/code capsule/code && ln -s \$PWD/capsule/code /code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run

	echo "[${task.tag}] completed!"
	"""
}

// capsule - Jinho's Copy of aind-ophys-quality-control-aggregator
process capsule_jinhos_copy_of_aind_ophys_quality_control_aggregator_16 {
	tag 'capsule-9974400'
	container "$REGISTRY_HOST/capsule/a3540977-81bb-4d55-ba2e-798576353f98"

	cpus 1
	memory '7.5 GB'

	publishDir "$RESULTS_PATH", saveAs: { filename -> new File(filename).getName() }

	input:
	path 'capsule/data/' from ophys_mount_to_jinho_s_copy_of_aind_ophys_quality_control_aggregator_43.collect()
	path 'capsule/data/' from capsule_aind_ophys_oasis_event_detection_9_to_capsule_jinhos_copy_of_aind_ophys_quality_control_aggregator_16_44.collect()
	path 'capsule/data/' from capsule_aind_ophys_oasis_event_detection_9_to_capsule_jinhos_copy_of_aind_ophys_quality_control_aggregator_16_45.collect()
	path 'capsule/data/' from capsule_aind_ophys_movie_qc_15_to_capsule_jinhos_copy_of_aind_ophys_quality_control_aggregator_16_46.collect()
	path 'capsule/data/' from capsule_aind_ophys_movie_qc_15_to_capsule_jinhos_copy_of_aind_ophys_quality_control_aggregator_16_47.collect()
	path 'capsule/data/' from capsule_aind_ophys_classifier_17_to_capsule_jinhos_copy_of_aind_ophys_quality_control_aggregator_16_48.collect()
	path 'capsule/data/' from capsule_aind_ophys_classifier_17_to_capsule_jinhos_copy_of_aind_ophys_quality_control_aggregator_16_49.collect()
	path 'capsule/data/' from capsule_aind_ophys_decrosstalk_roi_images_3_to_capsule_jinhos_copy_of_aind_ophys_quality_control_aggregator_16_50.collect()
	path 'capsule/data/' from capsule_aind_ophys_extraction_suite_2_p_4_to_capsule_jinhos_copy_of_aind_ophys_quality_control_aggregator_16_51.collect()
	path 'capsule/data/' from capsule_aind_ophys_motion_correction_1_to_capsule_jinhos_copy_of_aind_ophys_quality_control_aggregator_16_52.collect()

	output:
	path 'capsule/results/*'

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=a3540977-81bb-4d55-ba2e-798576353f98
	export CO_CPUS=1
	export CO_MEMORY=8053063680

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	if [[ "\$(printf '%s\n' "2.20.0" "\$(git version | awk '{print \$3}')" | sort -V | head -n1)" = "2.20.0" ]]; then
		git clone --filter=tree:0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-9974400.git" capsule-repo
	else
		git clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-9974400.git" capsule-repo
	fi
	mv capsule-repo/code capsule/code && ln -s \$PWD/capsule/code /code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run ${params.capsule_jinhos_copy_of_aind_ophys_quality_control_aggregator_16_args}

	echo "[${task.tag}] completed!"
	"""
}

// capsule - aind-ophys-classifier
process capsule_aind_ophys_classifier_17 {
	tag 'capsule-0630574'
	container "$REGISTRY_HOST/published/3819d125-9f03-48f3-ba09-b44c84a7a2c7:v4"

	cpus 4
	memory '200 GB'
	accelerator 1
	label 'gpu'

	publishDir "$RESULTS_PATH", saveAs: { filename -> new File(filename).getName() }

	input:
	path 'capsule/data/' from capsule_aind_ophys_extraction_suite_2_p_4_to_capsule_aind_ophys_classifier_17_53
	path 'capsule/data/' from ophys_mount_to_aind_ophys_classifier_54.collect()

	output:
	path 'capsule/results/*/*/*data_process.json' into capsule_aind_ophys_classifier_17_to_capsule_aind_pipeline_processing_metadata_aggregator_11_20
	path 'capsule/results/*/classification/*classification.h5' into capsule_aind_ophys_classifier_17_to_capsule_jinhos_copy_of_aind_ophys_nwb_12_28
	path 'capsule/results/*/*/*.json' into capsule_aind_ophys_classifier_17_to_capsule_jinhos_copy_of_aind_ophys_quality_control_aggregator_16_48
	path 'capsule/results/*/*/*.png' into capsule_aind_ophys_classifier_17_to_capsule_jinhos_copy_of_aind_ophys_quality_control_aggregator_16_49
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
	if [[ "\$(printf '%s\n' "2.20.0" "\$(git version | awk '{print \$3}')" | sort -V | head -n1)" = "2.20.0" ]]; then
		git clone --filter=tree:0 --branch v4.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-0630574.git" capsule-repo
	else
		git clone --branch v4.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-0630574.git" capsule-repo
	fi
	mv capsule-repo/code capsule/code && ln -s \$PWD/capsule/code /code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run

	echo "[${task.tag}] completed!"
	"""
}

# ReactOS Modern


install: 
copy the contents of bin/ to the root of the ReactOS repository

append the following to reactos/media/themes/CMakeLists.txt:         
	add_subdirectory(modern.msstyles)

append the following to reactos/modules/CMakeLists.txt:
	add_subdirectory(Silhouette)

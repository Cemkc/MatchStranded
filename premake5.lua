workspace "OvisEngine"
	architecture "x64"

	configurations{
		"Debug",
		"Release",
		"Dist"
	}

	startproject "Sandbox"

outputdir = "%{cfg.buildcfg}-%{cfg.system}-%{cfg.architecture}"

-- Create a dictionary for include paths realtive to root folder (solution directory)
IncludeDir = {}
IncludeDir["GLFW"] = "Ovis/vendor/GLFW/include"

-- Include premake5 file in GLFW path into this file
include "Ovis/vendor/GLFW"

project "Ovis"
	location "Ovis"
	kind "SharedLib"
	language "C++"

	targetdir("bin/" .. outputdir .. "/%{prj.name}")
	objdir("bin-int/" .. outputdir .. "/%{prj.name}")

	pchheader "ovpch.h"
	pchsource "Ovis/src/ovpch.cpp"

	files
	{
		"%{prj.name}/src/**.h",
		"%{prj.name}/src/**.cpp"
	}

	includedirs
	{
		"%{prj.name}/vendor/spdlog/include",
		"%{prj.name}/src",
		"%{IncludeDir.GLFW}"
	}

	links{
		"GLFW",
		"opengl32.lib"
	}

	filter "system:windows"
		cppdialect "C++17"
		staticruntime "On"
		systemversion "latest"

		defines
		{
			"OV_PLATFORM_WINDOWS",
			"OV_BUILD_DLL"
		}

		postbuildcommands
		{
			-- Create the destination folder if it doesn't exist
			("{MKDIR} \"../bin/" .. outputdir .. "/Sandbox/\""),

			-- Copy the built DLL to the destination folder
			("{COPYFILE} %{cfg.buildtarget.relpath} \"../bin/" .. outputdir .. "/Sandbox/\"")
		}

	filter "configurations:Debug"
		defines "OV_DEBUG"
		optimize "On"

	filter "configurations:Release"
		defines "OV_RELEASE"
		optimize "On"

	filter "configurations:Dist"
		defines "OV_DIST"
		optimize "On"

project "Sandbox"
	location "Sandbox"
	kind "ConsoleApp"
	language "C++"

	targetdir("bin/" .. outputdir .. "/%{prj.name}")
	objdir("bin-int/" .. outputdir .. "/%{prj.name}")

	files
	{
		"%{prj.name}/src/**.h",
		"%{prj.name}/src/**.cpp"
	}

	includedirs
	{
		"Ovis/vendor/spdlog/include",
		"Ovis/src"
	}

	links
	{
		"Ovis"
	}

	filter "system:windows"
		cppdialect "C++17"
		staticruntime "On"
		systemversion "latest"

		defines
		{
			"OV_PLATFORM_WINDOWS",
		}

	filter "configurations:Debug"
		defines "OV_DEBUG"
		optimize "On"

	filter "configurations:Release"
		defines "OV_RELEASE"
		optimize "On"

	filter "configurations:Dist"
		defines "OV_DIST"
		optimize "On"
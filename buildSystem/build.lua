function glfw_include()
    local baseFolder = debug.getinfo(1,'S').source:match("^@(.+)/buildSystem/build.lua$")
    includedirs { path.join(baseFolder, "include") }
end

function glfw_project(options)
    options = options or {}
    local baseFolder = debug.getinfo(1,'S').source:match("^@(.+)/buildSystem/build.lua$")

    project "glfw"
        kind "StaticLib"
        language "C"
        targetdir "%{wks.location}/bin/%{cfg.buildcfg}/%{prj.name}"
        location "%{wks.location}/%{prj.name}"

        files
        {
            path.join(baseFolder, "include/GLFW/*.h"),
            path.join(baseFolder, "src/context.c"),
            path.join(baseFolder, "src/platform.c"),
            path.join(baseFolder, "src/null_*.c"),
            path.join(baseFolder, "src/egl_context.*"),
            path.join(baseFolder, "src/init.c"),
            path.join(baseFolder, "src/input.c"),
            path.join(baseFolder, "src/internal.h"),
            path.join(baseFolder, "src/monitor.c"),
            path.join(baseFolder, "src/osmesa_context.*"),
            path.join(baseFolder, "src/vulkan.c"),
            path.join(baseFolder, "src/window.c"),
        }
        
        includedirs { path.join(baseFolder, "include") }
        
        filter "system:windows"
            defines "_GLFW_WIN32"
            files
            {
                path.join(baseFolder, "src/win32_*.*"),
                path.join(baseFolder, "src/wgl_context.*")
            }
            
        filter "system:linux"
            defines "_GLFW_X11"
            files
            {
                path.join(baseFolder, "src/glx_context.*"),
                path.join(baseFolder, "src/linux*.*"),
                path.join(baseFolder, "src/posix*.*"),
                path.join(baseFolder, "src/x11*.*"),
                path.join(baseFolder, "src/xkb*.*")
            }
        filter "system:macosx"
            defines "_GLFW_COCOA"
            files
            {
                path.join(baseFolder, "src/cocoa_*.*"),
                path.join(baseFolder, "src/posix_thread.h"),
                path.join(baseFolder, "src/nsgl_context.h"),
                path.join(baseFolder, "src/egl_context.h"),
                path.join(baseFolder, "src/osmesa_context.h"),

                path.join(baseFolder, "src/posix_thread.c"),
                path.join(baseFolder, "src/nsgl_context.m"),
                path.join(baseFolder, "src/egl_context.c"),
                path.join(baseFolder, "src/nsgl_context.m"),
                path.join(baseFolder, "src/osmesa_context.c"),                       
            }
        
        filter "action:vs*"
            defines "_CRT_SECURE_NO_WARNINGS"

        if options.dependson then
            dependson { options.dependson }
        end
end
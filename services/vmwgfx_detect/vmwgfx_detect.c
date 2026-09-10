#define LOG_TAG "vmwgfx_detect"

#include <cutils/log.h>
#include <cutils/properties.h>
#include <fcntl.h>
#include <inttypes.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <vmwgfx_drm.h>
#include <xf86drm.h>

// Missing from libdrm's copy of vmwgfx_drm.h
#ifndef DRM_VMW_PARAM_GL43
#define DRM_VMW_PARAM_GL43 16
#endif

// Values of ro.opengles.version
#define GLES_VERSION_20 131072
#define GLES_VERSION_30 196608
#define GLES_VERSION_31 196609

static int get_param(int fd, uint32_t param, uint64_t* value) {
    // The value is returned in the request, it is not a pointer
    struct drm_vmw_getparam_arg request = {
            .param = param,
    };
    int ret = drmCommandWriteRead(fd, DRM_VMW_GET_PARAM, &request, sizeof(request));
    if (!ret) *value = request.value;
    return ret;
}

int main() {
    int fd;
    uint64_t has_3d = 0, has_dx = 0, has_gl43 = 0;
    char gles_version[PROPERTY_VALUE_MAX];

    fd = drmOpenWithType("vmwgfx", NULL, DRM_NODE_RENDER);
    if (fd < 0) {
        ALOGE("drmOpen() failed, assuming 3D is supported");
        property_set("ro.vendor.graphics.3d", "1");
        return EXIT_FAILURE;
    }

    if (get_param(fd, DRM_VMW_PARAM_3D, &has_3d)) {
        ALOGE("Failed to get DRM_VMW_PARAM_3D, assuming 3D is supported");
        has_3d = 1;
    }
    property_set("ro.vendor.graphics.3d", has_3d ? "1" : "0");

    if (has_3d) {
        // Mesa svga picks the GLSL level by the host shader model: no SM4 (vgpu9)
        // is GL 2.1, vgpu10 / SM5 is GL 3.3 / 4.1, and GL43 is GL 4.3. They can do
        // GLES 2.0, 3.0 and 3.1. Old kernels fail these queries, and they are all
        // unsupported there.
        get_param(fd, DRM_VMW_PARAM_DX, &has_dx);
        get_param(fd, DRM_VMW_PARAM_GL43, &has_gl43);
        ALOGI("3D is supported, DX = %" PRIu64 " GL43 = %" PRIu64, has_dx, has_gl43);

        snprintf(gles_version, sizeof(gles_version), "%d",
                 has_gl43 ? GLES_VERSION_31 : (has_dx ? GLES_VERSION_30 : GLES_VERSION_20));
        property_set("ro.vendor.graphics.gles_version", gles_version);
    } else {
        ALOGW("3D is not supported");
    }

    close(fd);
    return EXIT_SUCCESS;
}

import org.gradle.api.tasks.Delete
import org.gradle.api.file.Directory

// Repositori global
allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

// Build output ke luar folder Android (optional custom)
//val newBuildDir: Directory = rootProject.layout.buildDirectory.dir("../../build").get()
//rootProject.layout.buildDirectory.value(newBuildDir)
//
//subprojects {
//    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
//    project.layout.buildDirectory.value(newSubprojectBuildDir)
//    project.evaluationDependsOn(":app")
//}

// Task clean
tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}

// 🔧 Tambahkan ini untuk Firebase
buildscript {
    repositories {
        google()
        mavenCentral()
    }

    dependencies {
        classpath ("com.google.gms:google-services:4.4.2")
    }
}


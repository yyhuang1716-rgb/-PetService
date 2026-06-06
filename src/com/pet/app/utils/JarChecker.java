package com.pet.app.utils;

import java.io.File;
import java.io.IOException;
import java.util.Enumeration;
import java.util.jar.JarEntry;
import java.util.jar.JarFile;

public class JarChecker {
    public static void main(String[] args) throws IOException {
        String libPath = "D:\\IntellijIDEA\\PetService\\web\\WEB-INF\\lib";
        File libDir = new File(libPath);
        boolean found = false;
        
        for (File jarFile : libDir.listFiles((dir, name) -> name.endsWith(".jar"))) {
            try (JarFile jar = new JarFile(jarFile)) {
                Enumeration<JarEntry> entries = jar.entries();
                while (entries.hasMoreElements()) {
                    JarEntry entry = entries.nextElement();
                    String name = entry.getName();
                    if (name.contains("ConditionalTagSupport") || name.contains("jakarta/servlet/jsp/jstl/core/")) {
                        System.out.println("Found in " + jarFile.getName() + ": " + name);
                        found = true;
                    }
                }
            }
        }
        
        if (!found) {
            System.out.println("ConditionalTagSupport NOT FOUND in any jar!");
            System.out.println("JSTL core directory contents check:");
            for (File jarFile : libDir.listFiles((dir, name) -> name.endsWith(".jar"))) {
                try (JarFile jar = new JarFile(jarFile)) {
                    Enumeration<JarEntry> entries = jar.entries();
                    while (entries.hasMoreElements()) {
                        JarEntry entry = entries.nextElement();
                        String name = entry.getName();
                        if (name.startsWith("jakarta/servlet/jsp/jstl/core/")) {
                            System.out.println(jarFile.getName() + ": " + name);
                        }
                    }
                }
            }
        }
    }
}

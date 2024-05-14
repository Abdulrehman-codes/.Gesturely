package com.example.fyp

import android.accessibilityservice.AccessibilityService
import android.util.Log
import android.view.accessibility.AccessibilityEvent
import android.view.accessibility.AccessibilityNodeInfo

class MyAccessibilityService : AccessibilityService() {
    companion object {
        var isFloatingButtonClicked = true
    }

    private val scrollOffset = 100 // Adjust this offset as needed

    override fun onAccessibilityEvent(event: AccessibilityEvent?) {
        event?.let {
            if (it.eventType == AccessibilityEvent.TYPE_WINDOW_STATE_CHANGED) {
                val packageName = it.packageName?.toString()
                Log.d("MyAccessibilityService", "Window state changed: $packageName")
                if (isTargetApp(packageName) && isFloatingButtonClicked) {
                    Log.d("MyAccessibilityService", "Detected target app and floating button click")
                    scrollScreen()
                    isFloatingButtonClicked = false // Reset the flag after scrolling
                }
            }
        }
    }

    private fun isTargetApp(packageName: String?): Boolean {
        return packageName?.startsWith("com.instagram") == true ||
                packageName?.startsWith("com.facebook") == true ||
                packageName?.startsWith("com.twitter") == true ||
                packageName?.startsWith("com.google.android.youtube") == true
    }

    override fun onInterrupt() {
        Log.d("MyAccessibilityService", "Service interrupted")
    }

    private fun scrollScreen() {
        val rootNode = rootInActiveWindow
        rootNode?.let {
            val scrollableNode = findScrollableNode(it)
            if (scrollableNode != null) {
                scrollableNode.performAction(AccessibilityNodeInfo.ACTION_SCROLL_FORWARD)
                Log.d("MyAccessibilityService", "Performed scroll action")
            } else {
                Log.d("MyAccessibilityService", "No scrollable node found")
            }
        } ?: run {
            Log.d("MyAccessibilityService", "Root node is null")
        }
    }

    private fun findScrollableNode(node: AccessibilityNodeInfo): AccessibilityNodeInfo? {
        if (node.isScrollable) {
            return node
        }
        for (i in 0 until node.childCount) {
            val childNode = node.getChild(i)
            val result = findScrollableNode(childNode)
            if (result != null) {
                return result
            }
        }
        return null
    }
}

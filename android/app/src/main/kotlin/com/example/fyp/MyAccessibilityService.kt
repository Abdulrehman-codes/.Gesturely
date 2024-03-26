package com.example.fyp

import android.accessibilityservice.AccessibilityService
import android.accessibilityservice.AccessibilityServiceInfo
import android.view.accessibility.AccessibilityEvent
import android.view.accessibility.AccessibilityNodeInfo

class MyAccessibilityService : AccessibilityService() {
    private var isFloatingButtonClicked = false
    private val scrollOffset = 100 // Adjust this offset as needed
    override fun onAccessibilityEvent(event: AccessibilityEvent?) {
        if (event?.eventType == AccessibilityEvent.TYPE_WINDOW_STATE_CHANGED) {
            val packageName = event.packageName?.toString()
            // Check if the user is in a social media app
            if (isSocialMediaApp(packageName) && isFloatingButtonClicked) {
                // Perform scrolling logic
                scrollScreen(scrollOffset)
                isFloatingButtonClicked = false // Reset the flag after scrolling
            }
        }
    }

    private fun isSocialMediaApp(packageName: String?): Boolean {
        return packageName?.startsWith("com.instagram") == true ||
                packageName?.startsWith("com.facebook") == true ||
                packageName?.startsWith("com.twitter") == true
    }

    override fun onInterrupt() {}

    private fun scrollScreen(offset: Int) {
        // Implement your scrolling logic here
        // For example, you can use AccessibilityNodeInfo to scroll content
        val rootNode = rootInActiveWindow
        rootNode?.let {
            val scrollableNode = findScrollableNode(it)
            scrollableNode?.performAction(AccessibilityNodeInfo.ACTION_SCROLL_FORWARD)
        }
    }

    private fun findScrollableNode(node: AccessibilityNodeInfo): AccessibilityNodeInfo? {
        if (node.childCount == 0) {
            if (node.isScrollable) {
                return node
            }
        } else {
            for (i in 0 until node.childCount) {
                val childNode = node.getChild(i)
                val result = findScrollableNode(childNode)
                if (result != null) {
                    return result
                }
            }
        }
        return null
    }
}